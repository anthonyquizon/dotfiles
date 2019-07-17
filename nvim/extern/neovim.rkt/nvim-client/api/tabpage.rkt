;;;; Copyright 2017-2018 Alejandro Sanchez
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

(require racket/class "../client.rkt")
(provide tabpage%)

(define tabpage%
  (class* object% (printable<%>)
    (init-field nvim id)

    (define-syntax-rule (define-api-methods (method name arg ...)
                                            ...)
      (begin
        (define/public (name #:async (async? #f) arg ...)
          (if async?
            (send nvim notify  (format "nvim_tabpage_~a" method) this arg ...)
            (send nvim request (format "nvim_tabpage_~a" method) this arg ...)))
        ...))

    (super-new)

    ;; ---[ printable<%> ]----------------------------------------------------
    (define/public (custom-print out quote-depth)
      (print (format "(object:tabpage% ~a)" id) out quote-depth))

    (define/public (custom-write out)
      (write (format "(object:tabpage% ~a)" id) out))

    (define/public (custom-display out)
      (display (format "(object:tabpage% ~a)" id) out))

    ;; -----------------------------------------------------------------------
    (define-api-methods
      ;; (-> (Vectorof window%))
      ("list_windows" list-windows)
      ;; (-> window%)
      ("get_win" get-window)
      ;; (-> Integer)
      ("get_number" get-number)
      ;; (-> String Packable)
      ("get_var" get-var name)
      ;; (-> String Packable Void)
      ("set_var" set-var name value)
      ;; (-> String Void)
      ("del_var" del-var name)
      ;; (-> Boolean)
      ("is-valid?" is-valid?))))
