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

(require msgpack "types.rkt")
(provide (struct-out rpc-session) RPC-Session RPC-Callback)

(define-type RPC-Callback (-> Message-Args Packable))

(struct rpc-session
  ;; loop       Thread serving as the event loop
  ;; outbox     Async channel for messages
  ;; pending    Hasheqv mapping message IDs to pending threads
  ;; methods    Hasheq mapping message methods (symbols) to callbacks
  ;; custodian  Custodian of the loop
  ([loop      : Thread]
   [outbox    : (Async-Channelof Message)]
   [pending   : (Mutable-HashTable Message-ID Thread)]
   [methods   : (Mutable-HashTable Symbol RPC-Callback)]
   [custodian : Custodian])
  #:type-name RPC-Session)
