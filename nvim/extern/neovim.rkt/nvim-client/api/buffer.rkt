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
(provide buffer%)

(define buffer%
  (class* object% (printable<%>)
    (init-field nvim id)

    (define-syntax-rule (define-api-methods (method name arg ...)
                                            ...)
      (begin
        (define/public (name #:async (async? #f) arg ...)
          (if async?
            (send nvim notify  (format "nvim_buf_~a" method) this arg ...)
            (send nvim request (format "nvim_buf_~a" method) this arg ...)))
        ...))

    (super-new)

    ;; ---[ printable<%> ]----------------------------------------------------
    (define/public (custom-print out quote-depth)
      (print (format "(object:buffer% ~a)" id) out quote-depth))

    (define/public (custom-write out)
      (write (format "(object:buffer% ~a)" id) out))

    (define/public (custom-display out)
      (display (format "(object:buffer% ~a)" id) out))

    ;; -----------------------------------------------------------------------
    (define-api-methods
      ;; (-> Integer)
      ("line_count" line-count)
      ;; (-> buffer% Hash Boolean)
      ("attach" attach send-buffer opts)
      ;; (-> buffer% Boolean)
      ("detach" detach buffer)
      ;; (-> Integer Integer Boolean (Vectorof String))
      ("get_lines" get-lines start end strict-indexing?)
      ;; (-> Integer Integer Boolean (Vectorof String) Void)
      ("set_lines" set-lines start end strict-indexing? replacement)
      ;; (-> String Packable)
      ("get_var" get-var name)
      ;; (-> String Packable Void)
      ("set_var" set-var name value)
      ;; (-> String Void)
      ("del_var" del-var name)
      ;; (-> Integer)
      ( "get_chagedtick"get-chagedtick)
      ;; (-> String (Vectorof Hash))
      ("get_keymap" get-keymap mode)
      ;; (-> Hash Hash)
      ("get_commands" get-commands opts)
      ;; (-> String Packable)
      ("get_option" get-option name)
      ;; (-> String Packable Void)
      ("set_option" set-option name value)
      ;; (-> String)
      ( "get_name"get-name)
      ;; (-> String Void)
      ("set_name" set-name name)
      ;; (-> Boolean)
      ("is_valid" is-valid?)
      ;; (-> String (Vector Integer Integer))
      ("get_mark" get-mark name)
      ;; (-> Integer String Integer Integer Integer Integer)
      ("add_highlight" add-highlight src-id hl-group line col-start col-end)
      ;; (-> Integer Integer Integer Void)
      ("clear_highlight" clear-highlight src-id line-start line-end)
      ;; (-> Integer Integer)
      ("get_offset" get-offset index)
      ;; (-> Boolean)
      ("is_loaded" is-loaded?)
      ;; (-> Integer Integer Integer Void)
      ("clear_namespace" clear-namespace ns-id line-start line-end)
      ;; (-> Integer Integer (Vectorof (U (Vector String String) (Vector String))) Dictionary Integer)
      ("set_virtual_text" set-virtual-text ns-id line chunks opts))))
