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

;; use: (import (nfx))

(define-library (Scheme+ nfx) ; R7RS

  (import (kawa base)
	  (Scheme+ n-arity)
	  (Scheme+ infix-with-precedence-to-prefix)
	  (Scheme+ operators-list) ;; bug transformers syntax
	  )


  (export $nfx$)


  
;; #|kawa:1|# (import (nfx))
;; #|kawa:2|# ($nfx$ 3 * 5 + 2)
;; 17

(define-syntax $nfx$

  (lambda (stx)
    
    (syntax-case stx ()

      ;; note that to have $nfx$ called you need at minimum to have 2 different operator causing an operator precedence question
      ;; and then at least those 2 operators must be between operands each, so there is a need for 3 operand
      ;; the syntax then looks like this : e1 op1 e2 op2 e3 ..., example : 3 * 4 + 2
      (($nfx$ e1 op1 e2 op2 e3 op ...) ; note: i add op because in scheme op ... could be non existent

       ;;#'(list e1 op1 e2 op2 e3 op ...)
       
	 (with-syntax ;; let
			 
		       ((parsed-args
			 ;; TODO : make n-arity for <- and <+ only (because could be false with ** , but not implemented in n-arity for now)
			 (n-arity ;; this avoid : '{x <- y <- z <- t <- u <- 3 * 4 + 1}
			   ;; SRFI-105.scm : !0 result = (<- (<- (<- (<- (<- x y) z) t) u) (+ (* 3 4) 1)) ;; fail set! ...
			   ;; transform in : '(<- x y z t u (+ (* 3 4) 1))
			   (car
			    (!*prec-generic #'(e1 op1 e2 op2 e3 op ...) ; apply operator precedence rules
				       ;;infix-operators-lst-for-parser-syntax
				       (get-infix-operators-lst-for-parser-syntax)
				       (lambda (op a b) (list op a b)))))))
		       (display "$nfx$ : parsed-args=") (display #'parsed-args) (newline)
		       #'parsed-args)))))

) ; end module

