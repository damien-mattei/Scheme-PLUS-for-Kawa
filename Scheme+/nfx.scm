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
	  (Scheme+ operators-list) ;; bug transformers syntax : infix-operators-lst-for-parser-syntax is not imported at macro phase
	  (Scheme+ operators)
	  (Scheme+ infix))


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

       ;;(begin ;; (display "$nfx$ : #'(e1 op1 e2 op2 e3 op ...) : ")
	      ;; (display #'(e1 op1 e2 op2 e3 op ...))
	      ;; (newline)
	      ;; (display (get-operators-lst-syntax)) (newline)
	      ;; (foo)
	      ;; (infix? #'(e1 op1 e2 op2 e3 op ...)
	      ;; 			    ;;operators-lst-syntax))
	      ;; 			    (get-operators-lst-syntax))
	      ;; (when (not (infix? #'(e1 op1 e2 op2 e3 op ...)
	      ;; 			    ;;operators-lst-syntax))
	      ;; 			    (get-operators-lst-syntax)))
	      ;; 			    ;;op-lst-stx))
		   
	      ;; 	   (error "$nfx$ : arguments do not form an infix expression : here is #'(e1 op1 e2 op2 e3 op ...) for debug:"
	      ;; 		  #'(e1 op1 e2 op2 e3 op ...)))
       
	 (with-syntax ;; let
			 
	     ((parsed-args

	       (begin
	       ;; (let* ((ifx-op-stx (get-infix-operators-lst-for-parser-syntax))
	       ;; 	      (op-lst-stx (apply append ifx-op-stx)))

		 ;; (display "$nfx$: #'(e1 op1 e2 op2 e3 op ...)=") (display #'(e1 op1 e2 op2 e3 op ...)) (newline)
		 		
		 ;; pre-check we have an infix expression because parser can not do it
		 ;;(display op-lst-stx) (newline)
		 (when (not (infix? #'(e1 op1 e2 op2 e3 op ...)
				    ;;operators-lst-syntax))
				    (get-operators-lst-syntax)))
				    ;;op-lst-stx))
		   
		   (error "$nfx$ : arguments do not form an infix expression : here is #'(e1 op1 e2 op2 e3 op ...) for debug:"
			  #'(e1 op1 e2 op2 e3 op ...)))

		 (let ((expr (car
			      (!*prec-generic #'(e1 op1 e2 op2 e3 op ...) ; apply operator precedence rules
					      ;;infix-operators-lst-for-parser-syntax
					      (get-infix-operators-lst-for-parser-syntax)
					      ;;ifx-op-stx
					      (lambda (op a b) (list op a b))))))

		   (if (or (isDEFINE? expr)
			   (isASSIGNMENT? expr))
		       ;;  make n-arity for <- and <+ only (because could be false with ** , but not implemented in n-arity for now)
		       (n-arity expr)
		       expr )))))
	   
	   (display "$nfx$ : parsed-args=") (display #'parsed-args) (newline)
	   #'parsed-args)))));) ; end begin
  
) ; end module

