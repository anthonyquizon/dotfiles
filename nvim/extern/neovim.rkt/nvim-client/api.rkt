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

(require "client.rkt"
         "api/nvim.rkt")

(provide (all-from-out "api/nvim.rkt") current-nvim-instance)

;;; Represents the current Nvim instance, for use in remote plugins
(define current-nvim-instance (make-parameter #f))

;;; API version the client was written for. Compare this the values of an
;;; instance when necessary.
(define version
  '#hash(("minor"          . 3)
         ("major"          . 0)
         ("patch"          . 4)
         ("api_level"      . 5)
         ("api_compatible" . 3)))
