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
#lang racket

;;; This is the bootstrap file for the Racket host; all the initialisation for
;;; the host is done here in Racket directly. This module is required by the
;;; host even before the client library is required.
;;;
;;; The reason this module is separate from the client library is because the
;;; actions performed here are specific to the host; normally all this would be
;;; done in VimScript and passed as command-line arguments to the Racket
;;; binary, but doing it in Racket is easier.

(require nvim/rplugin nvim/api nvim/client)

;;; When the host process is launched Nvim wants to load all the remote
;;; plugins. It sends an RPC request with a list of all plugin paths, so we
;;; require all the remote plugins, which will then in turn register their
;;; specs.


;;; Require a remote plugin so its RPC bindings can be imported into the
;;; current Neovim session
(define (load-remote-plugins paths)
  ;; Dynamically require a module so its side effects will get performed. This
  ;; will not import the bindings of the module, but we don't want them anyway.
  (for ([path (in-vector paths)])
    (load-remote-plugin path)))


;;; ===[ Boostrapping actions to perform ]=====================================
;;; The session will remain suspended until all RPC methods have been set up.
;;; The Neovim instance will be created by the handshake, which is the first
;;; message received.
;;;
;;; This way we avoid race conditions: the event loop will not process requests
;;; until all three methods have been set up. Otherwise it could start
;;; processing requests too early and fail. By setting up the Nvim instance in
;;; the first request we also make sure that it exists in all subsequent ones
;;; (Nvim will not send new requests until the handshake has been completed).
(define session (start-client #:suspend #t
                              (current-input-port) (current-output-port)))
(define nvim #f)

(parameterize ([current-rpc-session session])
  (register-rpc-method! 'poll
                        (λ (args)
                          (set! nvim (new nvim% (rpc-session session)))
                          "ok"))
  ;; These RPC methods are not part of the API, but they are sent by Neovim
  ;; when starting the host.
  (register-rpc-method! 'specs
                        (λ (args)
                          (parameterize ([current-nvim-instance nvim])
                            (path->specs (vector-ref args 0)))))
  (register-rpc-method! 'LoadRemotePlugins
                        (λ (args) 
                          (parameterize ([current-nvim-instance nvim])
                            (load-remote-plugins (vector-ref args 0))))))

;; All set, let's go!
(with-handlers ([exn:break:terminate? (λ (e) (stop-client session))])
  (thread-resume (rpc-session-loop session))
  (thread-wait (rpc-session-loop session)))
