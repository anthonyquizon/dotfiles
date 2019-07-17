;;;; Copyright 2017 Alejandro Sanchez
;;;;
;;;; This file is part of Neovim.rkt
;;;; 
;;;;     Neovim.rkt is free software: you can redistribute it and/or modify it
;;;;     under the terms of the GNU General Public License as published by the
;;;;     Free Software Foundation, either version 3 of the License, or (at your
;;;;     option) any later version.
;;;; 
;;;;     Neovim.rkt is distributed in the hope that it will be useful, but
;;;;     WITHOUT ANY WARRANTY; without even the implied warranty of
;;;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;;;     General Public License for more details.
;;;; 
;;;;     You should have received a copy of the GNU General Public License
;;;;     along with Neovim.rkt.  If not, see <http://www.gnu.org/licenses/>.
#lang typed/racket/base

;;; This module implements a complete MessagePack RPC client. When it matures
;;; sufficiently it should be made into its own MessagePack RPC library. To
;;; facilitate this the library must not leak any implementation.

(require "client/types.rkt"
         "client/rpc-session.rkt"
         "client/exn-fail-rpc.rkt"
         msgpack
         typed/racket/async-channel)

(provide rpc-session-loop  ; Only provide one accessor
         current-rpc-session
         rpc-request
         rpc-respond
         rpc-notify
         start-client
         stop-client
         register-rpc-method!
         (struct-out exn:fail:rpc))


;;; ===[ Module state ]========================================================
;;; All RPC actions will be relative to the current session
(define current-rpc-session
  (#{make-parameter @ (U RPC-Session Void) Void} (void)))

;;; State relative to the current session. State is kept in hash tables which
;;; map a session to the relevant values. The custodian covers all resources
;;; managed by the session, including those created through requests and
;;; notifications
(define (pend-request! [msg-id : Message-ID])
  (define session (assert (current-rpc-session) rpc-session?))
  (define pending (rpc-session-pending session))
  (hash-set! pending msg-id (current-thread)))

(define (unpend-request! [msg-id : Message-ID])
  (define session (assert (current-rpc-session) rpc-session?))
  (define pending (rpc-session-pending session))
  (hash-remove! pending msg-id))

(define get-pending-request
  (case-lambda
    [([msg-id : Message-ID])
     (define session (assert (current-rpc-session) rpc-session?))
     (define pending (rpc-session-pending session))
     (hash-ref pending msg-id)]
    [([msg-id : Message-ID] [failure-result : False])
     (define session (assert (current-rpc-session) rpc-session?))
     (define pending (rpc-session-pending session))
     (hash-ref pending msg-id failure-result)]))

(define (send-rpc-message [msg : Message])
  (define session (assert (current-rpc-session) rpc-session?))
  (define outbox (rpc-session-outbox session))
  (async-channel-put outbox msg))

(define (register-method! [method : Symbol] [callback : RPC-Callback])
  (define session (assert (current-rpc-session) rpc-session?))
  (define methods (rpc-session-methods session))
  (hash-set! methods method callback))

(: method-callback (-> Symbol RPC-Callback))
(define (method-callback [method : Symbol])
  (define session (assert (current-rpc-session) rpc-session?))
  (define methods (rpc-session-methods session))
  (hash-ref methods method
    (λ () (raise (format "No RPC handler registered for \"~a\"" method)))))

;;; Start the client event loop in its own thread.
(: start-client (->* (Input-Port Output-Port) (#:suspend Boolean) RPC-Session))
(define (start-client in out #:suspend [suspend? #f])
  ;; Outgoing RPC calls
  (define outbox (#{make-async-channel @ Message}))
  (define cust (make-custodian))
  ;; The tricky part is that when the thread receives RPC messages it needs
  ;; to know which session the messages belong to. Of course there is only
  ;; one session that makes sense, but this session does not exist when the
  ;; thread is created. Instead we will construct the session later and send
  ;; it to the thread.
  (define loop
    (parameterize ([current-custodian cust])
      (thread
        (λ ()
          (parameterize ([current-rpc-session (assert (thread-receive) rpc-session?)])
            (let loop ()
              (sync
                (handle-evt outbox
                  (λ (evt)
                    (pack-to out (cast evt Packable))
                    (flush-output out)))
                (handle-evt in
                  (λ ([evt : Input-Port])
                    (with-handlers ([exn:fail:read:eof? (λ (e) (void))])
                      (define msg (cast (unpack-from evt) Message))
                      (case (vector-ref msg 0)
                        [(0) (handle-request      (cast msg Request))]
                        [(1) (handle-response     (cast msg Response))]
                        [(2) (handle-notification (cast msg Notification))]
                        [else (raise "Illegal RPC type")])))))
              (loop)))))))
  (define session
    (rpc-session loop
                 outbox
                 (#{make-hasheqv @ Message-ID Thread})
                 (#{make-hasheq  @ Symbol RPC-Callback})
                 cust))
  (when suspend?
    (thread-suspend loop))
  (thread-send loop session)
  session)

;;; Stops the client by shutting down its custodian, which releases all
;;; resources held by the session and produced by any requests or
;;; notifications.
(define (stop-client [session : RPC-Session])
  (custodian-shutdown-all (rpc-session-custodian session)))


;;; Generate a new message ID for the current session with each invocation. A
;;; valid ID is an unsigned 32-bt integer which has no pending request
;;; associated with it.
;;;
;;; To find a valid ID start with the next number from the currently used ID.
;;; Keep going forward until we either hit a free spot or we have gone full
;;; circle.
(define generate-msg-id
  (let ([id-table (#{make-hasheq @ RPC-Session Message-ID})])
    ;; Increment an integer, rolling over to zero
    (define (add1_32 [z : Message-ID])
      (if (< z (sub1 (expt 2 32))) (add1 z) 0))
    (λ ()
      (define session (assert (current-rpc-session) rpc-session?))
      (define current (hash-ref id-table session (λ () 0)))
      (let loop : Message-ID ([next : Message-ID (add1_32 current)])
        (cond
          [(not (get-pending-request next #f))
           (hash-set! id-table session next)
           next]
          [(= current next)
           (raise "Request overflow: too many requests pending")]
          [else (loop (add1_32 next))])))))


;;; ===[ Public RPC interface ]===============================================

;;; Register a method with a given method name and callback function in the
;;; current session.
(define (register-rpc-method! method callback)
  (register-method! method callback))

;;; Send a MsgPack RPC request to the server, expect a response.
(define (rpc-request [method : String] [params : Message-Args])
  (define msg-id (generate-msg-id))
  ;; Post the message to the event loop so it can be sent off. Register the
  ;; current thread as pending so we can receive the response.
  (pend-request! msg-id)
  (send-rpc-message (request msg-id method params))
  ;; We get both an error and a result; only if the error is void proceed
  (let ([error  (cast (thread-receive) Packable)]
        [result (cast (thread-receive) Packable)])
    (unpend-request! msg-id)
    (cond
      [(void? error) result]
      [else
        (raise (exn:fail:rpc (format "MessagePack-RPC error: ~a" error)
                             (current-continuation-marks)
                             error))])))

;;; Send a MsgPack RPC response to the server
(define (rpc-respond [msg-id : Message-ID] [error : Packable] [result : Packable])
  (send-rpc-message (response msg-id error result)))

;;; Send a MsgPack RPC notification to the server, do not expect a response.
(define (rpc-notify [method : String] [params : Message-Args])
  (send-rpc-message (notification method params)))


;;; ===[ Message handling ]====================================================
;;; Requests and responses run their tasks in a separate thread for each task.
;;; These task threads can block, but the event loop will be able to continue.
;;; When a request thread has finished it will send a response which the event
;;; loop can collect and send back to the server.
;;;
;;; Responses are sent to their corresponding request threads so that the
;;; request thread can continue. The response is wrapped in a thunk so that it
;;; can raise an error in the request thread if necessary.

(define (handle-request [msg : Request])
  (define msg-id : Message-ID   (vector-ref msg 1))
  (define method : String       (vector-ref msg 2))
  (define params : Message-Args (vector-ref msg 3))
  ;; Take the value of the exception and send it back as an error response
  (define (on-exception [exn : exn:fail:rpc])
    (define val (exn:fail:rpc-val exn))
    (rpc-respond msg-id val (void)))
  (define (on-fail exn)
    (rpc-respond msg-id "You fucking idiot!" (void)))

  (parameterize ([current-custodian (rpc-session-custodian (cast (current-rpc-session) RPC-Session))])
    (thread
      (λ ()
        (with-handlers ([exn:fail:rpc? on-exception]
                        [exn:fail?     on-fail])
          (define proc (method-callback (string->symbol method)))
          (rpc-respond msg-id (void) (proc params)))))))

(define (handle-response [msg : Response])
  (define msg-id  : Message-ID (vector-ref msg 1))
  (define error   : Packable   (vector-ref msg 2))
  (define result  : Packable   (vector-ref msg 3))
  (define request : Thread     (get-pending-request msg-id))
  (thread-send request error)
  (thread-send request result))

(define (handle-notification [msg : Notification])
  (define method : String       (vector-ref msg 1))
  (define params : Message-Args (vector-ref msg 2))
  (define session (assert (current-rpc-session) rpc-session?))
  (parameterize ([current-custodian (rpc-session-custodian session)])
    (thread
      (λ ()
        ;; Ignore errors, we have no way of knowing how to notify the server
        ;; about the failure in this primitive module.
        (with-handlers ([exn:fail:rpc? (λ (exn) (void))])
          (define proc (method-callback (string->symbol method)))
          (proc params))))))
