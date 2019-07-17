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
#lang racket/base

(require "client.rkt" "api.rkt")
(provide load-remote-plugin
         path->specs
         nvim-function
         nvim-command
         nvim-autocmd)


;;; ===[ Module state ]========================================================
;;; Path to the current remote plugin; will be parameterised by each remote
;;; plugin with its own remote path.
(define current-rplugin (make-parameter (void)))

(define (load-remote-plugin path)
  (parameterize ([current-rplugin path])
    (dynamic-require (string->path (current-rplugin)) 0)))

(define-values (path->specs register-spec!)
  ;; Hash table of remote plugin specifications. The key is the path of the
  ;; remote plugin, the value is a list of specifications, each of which is a
  ;; hash table as well.
  (let ([spec-table (make-hash)])
    (values
      ;; Map a path to its spec hash-table
      (λ (path)
        (hash-ref spec-table path
          (λ () (raise (format "No specifications for remote plugin '~a'"
                               path)))))
      ;; Register the specifications of a remote plugin
      (λ (spec request proc)
        (define path (current-rplugin))
        (define method-name (string->symbol (format "~a:~a" path request)))
        ;; Initialise the specifications list, prepend the new specification to
        ;; the list and hook up the RPC request
        (hash-set! spec-table path (cons spec (hash-ref spec-table path '())))
        (register-rpc-method! method-name proc)))))


;;; ===[ Define remote functions, commands and auto-commands ]=================
;;; Each remote plugin callback is run in its own thread, which will then have
;;; its current Nvim instance parameter set to the default value. Therefore we
;;; have to wrap each procedure in a lambda that sets the parameter to the Nvim
;;; instance which is current when the plugin is being loaded before calling
;;; the procedure.

(define (nvim-function name proc #:range [range?     #f]
                                 #:eval  [eval   (void)]
                                 #:sync  [sync?      #t])
  (define nvim (current-nvim-instance))
  (define opts (make-hash))
  (define spec `#hash(("type" . "function")
                      ("name" . ,name)
                      ("sync" . ,sync?)
                      ("opts" . ,opts)))
  (when range?
    (hash-set! opts "range" (if (eq? range? #t) "" range?)))
  (unless (void? eval)
    (hash-set! opts "eval" eval))
  (register-spec! spec (format "function:~a" name)
    (λ (args)
      (parameterize ([current-nvim-instance nvim])
        (apply proc (vector->list args))))))

(define (nvim-command name proc #:nargs    [nargs          0]
                                #:complete [complete      #f]
                                #:range    [range         #f]
                                #:count    [count         #f]
                                #:bang     [bang?         #f]
                                #:register [register?     #f]
                                #:eval     [eval      (void)]
                                #:sync     [sync?         #t])
  (define nvim (current-nvim-instance))
  (define opts (make-hash))
  (define spec `#hash(("type" . "command")
                      ("name" . ,name)
                      ("sync" . ,sync?)
                      ("opts" . ,opts)))
  (cond
    [range (hash-set! opts "range" (if (eq? range #t) "" range))]
    [count (hash-set! opts "count" count)])
  (cond
    [(char? nargs) (hash-set! opts "nargs" (format "~a" nargs))]
    [(not (zero? nargs)) (hash-set! opts    "nargs"     nargs)])
  (when              bang? (hash-set! opts     "bang"        ""))
  (when          register? (hash-set! opts "register"        ""))
  (when           complete (hash-set! opts "complete"  complete))
  (unless (void?     eval) (hash-set! opts     "eval"      eval))

  (register-spec! spec (format "command:~a" name)
    (λ (args)
      (parameterize ([current-nvim-instance nvim])
        (apply proc (vector->list args))))))

(define (nvim-autocmd name proc #:pattern [pattern    "*"]
                                #:eval    [eval    (void)]
                                #:sync    [sync?       #f])
  (define nvim (current-nvim-instance))
  (define opts (make-hash `(("pattern" . ,pattern))))
  (define spec `#hash(("type" . "autocmd")
                      ("name" . ,name)
                      ("sync" . ,sync?)
                      ("opts" . ,opts)))
  (unless (void? eval)
    (hash-set! opts "eval" eval))
  (register-spec! spec (format "autocmd:~a:~a" name pattern)
    (λ (args)
      (parameterize ([current-nvim-instance nvim])
        (apply proc (vector->list args))))))
