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
#lang info

(define name "nvim-client")
(define scribblings '(["scribblings/nvim-client.scrbl" (multi-page)]))
(define collection "nvim")
(define version "0.0.0")
(define pkg-desc "Neovim API client library")
(define deps '("base"
               "msgpack"
               "unix-socket-lib"
               "typed-racket-lib"
               "typed-racket-more"
               "scribble-lib"))
(define build-deps '("unix-socket-doc"
                     "rackunit-lib"
                     "racket-doc"
                     "scribble-lib"))
