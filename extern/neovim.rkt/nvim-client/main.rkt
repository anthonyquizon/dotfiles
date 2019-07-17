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

(require "client.rkt" "api.rkt" "rplugin.rkt" racket/class)

(provide (all-from-out "api.rkt")
         (all-from-out "rplugin.rkt")
         current-nvim-instance
         nvim-attach)

;;; Attach to an existing Nvim instance with input- and output ports
(define (nvim-attach in out)
  (define rpc-session (start-client in out))
  (new nvim% [rpc-session rpc-session]))
