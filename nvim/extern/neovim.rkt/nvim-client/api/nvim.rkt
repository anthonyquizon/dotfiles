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

(require racket/class
         racket/vector
         racket/port
         msgpack
         "buffer.rkt"
         "window.rkt"
         "tabpage.rkt"
         "../client.rkt")
(provide nvim%)


(define nvim%
  (class object%
    (init-field [(session rpc-session)])

    (define-values (channel-id api-info)
      (parameterize ([current-rpc-session session])
        (let ([info (rpc-request "nvim_get_api_info" '#())])
          (values (vector-ref info 0)
                  (vector-ref info 1)))))

    ;; -----------------------------------------------------------------------
    ;; Decode MessagePack object into an object used by API bindings
    (define (decode obj)
      (define types (hash-ref api-info "types"))
      ;; Map RPC type index to class (see :h rpc-types)
      (define (type-id->class type)
        (cond
          [(= type (hash-ref (hash-ref types  "Buffer") "id"))  buffer%]
          [(= type (hash-ref (hash-ref types  "Window") "id"))  window%]
          [(= type (hash-ref (hash-ref types "Tabpage") "id")) tabpage%]
          [else (error "Unknown MsgPack extension type" type)]))
      ;; Map object and RPC type name to MsgPack Ext object
      (define (object->ext obj type)
        (ext (hash-ref (hash-ref types type) "id")
             (pack (get-field id obj))))

      (cond
        [(vector? obj)
         (for/vector #:length (vector-length obj) ([v (in-vector obj)])
           (decode v))]
        [(hash? obj)
         (for/hash ([(k v) (in-hash obj)])
           (values (decode k) (decode v)))]
        [(ext? obj)
         (new (type-id->class (ext-type obj))
              [nvim this]
              [id (unpack (ext-data obj))])]
        [(is-a? obj  buffer%) (object->ext obj  "Buffer")]
        [(is-a? obj  window%) (object->ext obj  "Window")]
        [(is-a? obj tabpage%) (object->ext obj "Tabpage")]
        [else obj]))

    ;; -----------------------------------------------------------------------
    ;; Wrap MessagePack API request
    (define-syntax-rule (define-api-methods (method name arg ...)
                                            ...)
      (begin
        (define/public (name #:async (async? #f) arg ...)
          (parameterize ([current-rpc-session session])
          (if async?
            (notify  (format "nvim_~a" method) arg ...)
            (request (format "nvim_~a" method) arg ...))))
        ...))

    ;; -----------------------------------------------------------------------
    (super-new)

    ;; ---[ Raw RPC calls ]---------------------------------------------------
    ;; These should generally not be called by end-users, but they they still
    ;; exists for performing raw RPCing.
    (define/public (request method . args)
      (define (on-error exn)
        (define val (exn:fail:rpc-val exn))
        (raise (exn:fail:rpc (format "Nvim RPC error: ~a" val)
                             (current-continuation-marks)
                             val)))
      (parameterize ([current-rpc-session session])
        (with-handlers ([exn:fail:rpc? on-error])
          (decode (rpc-request method (vector-map! decode (list->vector args)))))))

    (define/public (notify method . args)
      (parameterize ([current-rpc-session session])
        (void (rpc-notify method (vector-map! decode (list->vector args))))))

    ;; ---[ API wrappings ]---------------------------------------------------
    (define-api-methods
      ;; (-> String Void)
      ("command" command cmd)
      ;; (-> String Boolean Hash)
      ("get_hl_by_name" get-hl-by-name name rgb?)
      ;; (-> Integer Boolean Hash)
      ("get_hl_by_id" get-hl-by-id id rgb?)
      ;; (-> String String Boolean Void)
      ("feedkeys" feedkeys keys mode escape-csi?)
      ;; (-> String Integer)
      ("input" input keys)
      ;; (-> String Boolean Boolean Boolean String)
      ("replace_termcodes" replace-termcodes str from-part? do-lt? special?)
      ;; (-> String String)
      ("command_output"  command-output str)
      ;; (-> String Packable)
      ("eval" eval expr)
      ;; (-> String Vector Packable)
      ("call_function" call-function fname args)
      ;; (-> Object String Vector)
      ("call_dict_function" call-dict-function dict fn args)
      ;; (-> String Vector Packable)
      ("excute_lua" execute-lua code args)
      ;; (-> String Integer)
      ("strwidth" strwidth text)
      ;; (-> (Vectorof String))
      ("list_runtime_paths" list-runtime-paths)
      ;; (-> String Void)
      ("set_current_dir" set-current-dir dir)
      ;; (-> String)
      ("get_current_dir" get-current-dir)
      ;; (-> String Void)
      ("set_current_line" set-current-line line)
      ;; (-> String)
      ("get_current_line" get-current-line)
      ;; (-> Void)
      ("del_current_line" del-current-line)
      ;; (-> String Packable Void)
      ("set_var" set-var name value)
      ;; (-> String Packable)
      ("get_var" get-var name)
      ;; (-> String Void)
      ("del_var" del-var name)
      ;; (-> String Packable)
      ("get_vvar" get-vvar name)
      ;; (-> String Packable Void)
      ("set_option" set-option name value)
      ;; (-> String Packable)
      ("get_option" get-option name)
      ;; (-> String Void)
      ("out_write" out-write str)
      ;; (-> String Void)
      ("err_write" err-write str)
      ;; (-> String Void)
      ("err_writeln" err-writeln str)
      ;; (-> (Vectorof buffer%))
      ("list_bufs" list-bufs)
      ;; (-> buffer%)
      ("get_current_buf" get-current-buf)
      ;; (-> buffer% Void)
      ("set_current_buf" set-current-buf buffer)
      ;; (-> (Vectorof window%))
      ("list_wins" list-wins)
      ;; (-> window%)
      ("get_current_win" get-current-win)
      ;; (-> window% Void)
      ("set_current_win" set-current-win window)
      ;; (-> (Vectorof tabpage%))
      ("list_tabpages" list-tabpages)
      ;; (-> tabpage%)
      ("get_current_tabpage" get-current-tabpage)
      ;; (-> tabpage% Void)
      ("set_current_tabpage" set-current-tabpage tabpage)
      ;; (-> String Void)
      ("subscribe" subscribe event)
      ;; (-> String Void)
      ("unsubscribe" unsubscribe event)
      ;; (-> String Integer)
      ("get_color_by_name" get-color-by-name name)
      ;; (-> Hash)
      ("get_color_map" get-color-map)
      ;; (-> Hash)
      ("get_mode" get-mode)
      ;; (-> String (Vectorof Hash))
      ("get_keymap" get-keymap mode)
      ;;(-> Hash Hash)
      ("get_commands" get-commands opts)
      ;; (-> Vector)
      ("get_api_info" get-api-info)
      ;; (-> String Hash String Hash Hash Void)
      ("set_client_info" set-client-info name version type methods attributes)
      ;; (-> Integer Dictionary)
      ("get_chan_info" get-chan-info chan)
      ;; (-> Vector)
      ("get_chans" list-chans)
      ;; (-> String String Boolean Hash)
      ("parse_expression" parse-expression expr flags highlight)
      ;; (-> Vector)
      ("list_uis" list-uis)
      ;; (-> Integer Vector)
      ("get_proc_children" get-proc-children pid)
      ;; (-> Integer Object)
      ("get_proc" get-proc pid)
      ;; (-> Vector Vector)
      ("call_atomic" call-atomic calls)
      ;; (-> String Integer)
      ("create_namespace" create-namespace name)
      ;; (-> Dictionary)
      ("get_namespace" get-namespace)
      ;; ---[ UI functions ]----------------------------------------------------
      ;; (-> Integer Integer Hash Void)
      ("ui_attach" ui-attach width height options)
      ;; (-> Void)
      ("ui_detach" ui-detach)
      ;; (-> Integer Integer Void)
      ("ui_try_resize" ui-try-resize width height)
      ;; (-> String Packable Void)
      ("ui_set_option" ui-set-option name value))))
