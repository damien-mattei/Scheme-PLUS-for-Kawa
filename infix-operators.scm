;; kawa version

;; This file is part of Scheme+

;; Copyright 2023 Damien MATTEI

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


(module-name infix-operators)

(export infix-operators-lst
	set-infix-operators-lst!
	replace-operator!
	insert-operator!)

(include "exponential.scm")
(include "modulo.scm")
(include "bitwise.scm")
(include "not-equal.scm")

(include "first-and-rest.scm")
(include "list.scm")
	

;; can you believe they made && and || special forms??? yes :-) but with advantage of being short-circuited,but i admit it has been a headlock for an infix solution 
;; note: difference between bitwise and logic operator


;; a list of lists of operators. lists are evaluated in order, so this also
;; determines operator precedence
;;  added bitwise operator with the associated precedences and modulo too
(define infix-operators-lst
  
  
  (list 0
	
	(list expt **)
	(list * / %)
	(list + -)
	
	(list << >>)

	(list & ∣)

  					; now this is interesting: because scheme is dynamically typed, we aren't
  					; limited to any one type of function
	
	(list < > = ≠ <= >= <>)
	
	;;(list 'dummy) ;; can keep the good order in case of non left-right assocciative operators.(odd? reverse them) 
	
	)

  )


(define (set-infix-operators-lst! lst)
  (set! infix-operators-lst lst))

(define (replace-operator! op-old op-new)
  (display "replace-operator! :") (newline)
  ;; (display op-old) (newline)
  ;; (display op-new) (newline)
  (display infix-operators-lst) (newline)(newline)
  (define version-number (car infix-operators-lst))
  (define new-infix-operators-lst (replace infix-operators-lst op-old op-new))
  (set-infix-operators-lst! (cons (+ 1 version-number) ; increment the version number
				  (cdr new-infix-operators-lst)))
  (display infix-operators-lst) (newline)(newline))



(define (insert-operator! op-old op-new)
  (display "insert-operator! :") (newline)
  ;; (display op-old) (newline)
  ;; (display op-new) (newline)
  (display infix-operators-lst) (newline)(newline)
  (define version-number (car infix-operators-lst))
  (define new-infix-operators-lst (insert-if-member  infix-operators-lst op-old op-new))
  (set-infix-operators-lst! (cons (+ 1 version-number) ; increment the version number
				  (cdr new-infix-operators-lst)))
  (display infix-operators-lst) (newline)(newline))

