;; check that expression is infix


;; This file is part of Scheme+

;; Copyright 2024 Damien MATTEI

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

(define-library (Scheme+ infix) ; R7RS

  (import (kawa base)
	  ;;(syntax)
	  ;;(Scheme+ syntax-plus) ;;  bug in Kawa
	  (srfi 1)
	  )

  (export infix?)

  
;; modified for syntax too



(define (datum=? obj1 obj2)
    (eq? (syntax->datum obj1)
	 (syntax->datum obj2)))

  ;; (define op-lst (list #'* #'+ #'- #'/))
  ;; op-lst
  ;; (#<syntax#10 * in #151> #<syntax#11 + in #152> #<syntax#12 - in #153>
  ;;  #<syntax#13 / in #154>)
  ;;  (member-syntax #'+ op-lst)
  ;;#t


;;   #|kawa:9|# (member-syntax '+ '(- + / *))
;; #t
;; #|kawa:10|# (member-syntax + (list - + / *))
;; #t
;; #|kawa:11|# (member-syntax + (list - / *))
;; #f
;; #|kawa:12|# (member-syntax '+ '(- / *))
;; #f

  (define (member-syntax x lst)
    (any (lambda (y)
	   ;; (display "member-syntax : x=") (display x) (newline)
	   ;; (display "member-syntax : y=") (display y) (newline)
	   ;; (newline)
	   ;;(check-syntax=? x y))
	   (datum=? x y))
	 lst))



  
;; check that expression is infix
(define (infix? expr oper-lst)

  ;; (display "infix? : expr=") (display expr) (newline)
  ;; (display "infix? : oper-lst=") (display oper-lst) (newline)
  
  (define (infix-rec? expr) ; (op1 e1 op2 e2 ...)
    ;;(display "infix-rec? : expr=") (display expr) (newline)
    (if (null? expr)
	#t
    	(and (not (null? (cdr expr))) ; forbids: op1 without e1
	     (member-syntax (car expr) oper-lst) ;; check (op1 e1 ...) 
	     (not (member-syntax (cadr expr) oper-lst)) ; check not (op1 op2 ...)
	     (infix-rec? (cddr expr))))) ; continue with (op2 e2 ...) 


  (define rv
    (cond ((not (list? expr)) (not (member-syntax expr oper-lst))) ; not an operator ! 
	  ((null? expr) #t) ; definition
	  ((null? (cdr expr)) #f) ; (a) not allowed as infix
	  (else
	   (and (not (member-syntax (car expr) oper-lst)) ; not start with an operator !
		(infix-rec? (cdr expr)))))) ; sublist : (op arg ...) match infix-rec
  
  ;;(display "infix? : rv=") (display rv) (newline)

  rv
  
  )) ; end library

