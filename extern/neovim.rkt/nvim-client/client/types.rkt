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

(require msgpack)

(provide Message-ID Message-Args)
(provide Request Response Notification Message)
(provide request response notification)


;;; TODO The ID of requests and responses must be a 32-bit number
(define-type Message-ID Nonnegative-Integer)
(define-type Message-Args (Vectorof Packable))

;;; See the MessagePack RPC specification for the meaning of these types
(define-type Request      (Vector 0 Message-ID String   Message-Args))
(define-type Response     (Vector 1 Message-ID Packable Packable))
(define-type Notification (Vector 2            String   Message-Args))
;;; A message is any of these
(define-type Message (U Request Response Notification))


;;; ---[ Constructors ]-------------------------------------------------------
;;; These constructors are wrappers creating objects suitable for static type
;;; checking.

(: request (-> Message-ID String Message-Args Request))
(define (request id method params)
  (vector 0 id method params))

(: response (-> Message-ID Packable Packable Response))
(define (response id error result)
  (vector 1 id error result))

(: notification (-> String Message-Args Notification))
(define (notification method args)
  (vector 2 method args))

