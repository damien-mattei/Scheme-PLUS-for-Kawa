;; Copyright 2022-2024 Damien MATTEI

;; kawa version

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.





(define-library (increment) ; R7RS

  (import (kawa base))
  
  (export incf
	  inc!
	  add1)


;; increment variable
;; this is different than add1 in DrRacket
(define-syntax incf
  (syntax-rules ()
    ((_ x)   (begin (set! x (+ x 1))
		    x))))

(define-syntax inc!
  (syntax-rules ()
    ((_ x)   (begin (set! x (+ x 1))
		    x))))

(define-syntax add1
  (syntax-rules ()
    ((_ x)   (+ x 1))))

) ; end module
