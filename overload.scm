
;; overload

;; Damien Mattei

;; This file is part of Scheme+


;; Copyright 2021-2024 Damien MATTEI

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



;; Kawa version

;; use with Scheme+: (require overload)

;;(module-name overload)


(define-library (overload) ; R7RS

  (import (kawa base)
	  (srfi 1)
	  (srfi 69) ; hash table
	  (condx)) 


;;(require infix-operators) ;  on s'en fout car on parse de la syntaxe

(export define-overload-procedure
	overload-procedure
	
	define-overload-existing-procedure
	overload-existing-procedure
	
	define-overload-operator
	overload-operator
	
	define-overload-existing-operator
	overload-existing-operator
	
	define-overload-n-arity-operator
	overload-n-arity-operator

	define-overload-existing-n-arity-operator
	overload-existing-n-arity-operator
	
	;;overload-function ;; see how to do the same for operator, see the possible problem with infix precedence?

	$ovrld-ht$

	$ovrld-square-brackets-lst$
	
	overload-square-brackets
	;;find-getter-and-setter-for-overloaded-square-brackets
	find-getter-for-overloaded-square-brackets
	find-setter-for-overloaded-square-brackets
	
	)


;; Warning: overload is now a module to prevent infinite recursion in case someone overload a scheme procedure used in the implementation of any of the procedures provided by overload.scm (example: length !)



(define $ovrld-ht$ (make-hash-table)) ;; for procedure and operators

(define $ovrld-square-brackets-lst$ '()) ;; for square brackets


;; overload tests

;; (display "before add-list-list") (newline)
;; (define (add-list-list v1 v2) (map + v1 v2))
;; (display "before define-overload") (newline)

;; (define-overload-existing-n-arity-operator +)

;; (define-overload-existing-operator *)

;; (define-overload-existing-n-arity-operator -)

;; (define (add-n-lists . vn-lst) (implementation-add-n-lists vn-lst))

;; (define (sub-n-lists . vn-lst) (implementation-sub-n-lists vn-lst))

;; (define-overload-existing-procedure length)
;; (define-overload-procedure foobie)


;; (define (implementation-add-n-lists vn-lst)
;;   {map-args <+ (cons + vn-lst)}
;;   (apply map map-args))


;; (define (implementation-sub-n-lists vn-lst)
;;   {map-args <+ (cons - vn-lst)}
;;   (apply map map-args))



;; (overload-existing-n-arity-operator + add-n-lists (list? list?))



;; ;; > {'(1 2 3) - '(4 5 6) - '(7 8 9)}
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = ((1 2 3) (4 5 6) (7 8 9))
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (1 4 7)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (2 5 8)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (3 6 9)
;; ;; '(-10 -11 -12)
;; ;; > (+ '(1 2 3) '(4 5 6))
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = ((1 2 3) (4 5 6))
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (1 4)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (2 5)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (3 6)
;; ;; '(5 7 9)
;; ;; > {'(1 2 3) - '(4 5 6)}
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = ((1 2 3) (4 5 6))
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (1 4)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (2 5)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (3 6)
;; ;; '(-3 -3 -3)
;; ;; > (- '(1 2 3) '(4 5 6))
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = ((1 2 3) (4 5 6))
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (1 4)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (2 5)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (3 6)
;; ;; '(-3 -3 -3)
;; ;; > (- '(1 2 3))
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = ((1 2 3))
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (1)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (2)
;; ;; check-arguments-for-n-arity : type = #<procedure:list?>
;; ;; check-arguments-for-n-arity : args = (3)
;; ;; '(-1 -2 -3)
;; (overload-existing-n-arity-operator - sub-n-lists (list? list?))

;; (display "+ =") (display +) (newline)

;; (+ '(1 2) '(3 4))

;; (display "before mult-num-list") (newline)
;; (define (mult-num-list k v) (map (lambda (x) (* k x)) v))

;; (overload-existing-operator * mult-num-list (number? list?))



;; {t <+ {3 * '(1 2 3) + '(4 5 6) + '(7 8 9)}}
;; (display t) (newline)

;; ;; ../../Scheme-PLUS-for-Racket/main/Scheme-PLUS-for-Racket/overload.scm:600:7: require: not at module level or top level in: (require (rename-in racket/base (* orig-proc)))
;; ;; (define (foo) ;; ko
;; ;;   ;;(declare x)
;; ;;   (define x 23)
;; ;;   (display "before define mult-num-list") (newline)
;; ;;   (define (mult-num-list k v) (map (lambda (x) (* k x)) v))
;; ;;   (display "before overload *") (newline)
;; ;;   (define-overload-existing-operator *)
;; ;;   (overload * mult-num-list (number? list?))
;; ;;   {t <+ {3 * '(1 2 3) + '(4 5 6) + '(7 8 9)}}
;; ;;   {x <- 1 + x + 4 * 5}
;; ;;   t)



;; (overload-existing-procedure length vector-length (vector?))
;; (overload-existing-procedure length string-length (string?))

;; (length #(1 2 3 4))
;; (length '(1 2 3))
;; (length "abcde")


(define-syntax overload

  (syntax-rules ()

    ;; arguments are function to be overloaded, procedure that do the overloading, list of predicate to check the arguments

    ((_ orig-funct funct (pred-arg1 ...))

     (let* ((qorig-funct (quote orig-funct))
	    (ovrld-lst (hash-table-ref $ovrld-ht$ qorig-funct)))
       ;;(display qorig-funct) (newline)
       (hash-table-set! $ovrld-ht$ qorig-funct
			(cons (list (list pred-arg1 ...) ;; example: ((number? string?) (lambda (n s) (display n) (display s) (newline)))
				    funct)
			      ovrld-lst))))))
 	 



(define-syntax overload-procedure
  
  (syntax-rules ()

    ((_ orig-funct funct (pred-arg1 ...))

     (overload orig-funct funct (pred-arg1 ...)))))



(define-syntax overload-existing-procedure
  
  (syntax-rules ()

    ((_ orig-funct funct (pred-arg1 ...))

     (overload orig-funct funct (pred-arg1 ...)))))


(define-syntax overload-operator
  
  (syntax-rules ()

    ((_ orig-funct funct (pred-arg1 ...))

     (overload orig-funct funct (pred-arg1 ...)))))



(define-syntax overload-existing-operator
  
  (syntax-rules ()

    ((_ orig-funct funct (pred-arg1 ...))

     (overload orig-funct funct (pred-arg1 ...)))))




(define-syntax overload-n-arity-operator
  
  (syntax-rules ()

    ((_ orig-funct funct (pred-arg1 ...))

     (overload orig-funct funct (pred-arg1 ...)))))


(define-syntax overload-existing-n-arity-operator
  
  (syntax-rules ()

    ((_ orig-funct funct (pred-arg1 ...))

     (overload orig-funct funct (pred-arg1 ...)))))





;; args must be the same number as predicates and their types must match
;;  (check-arguments '() '())
;; #t
(define (check-arguments pred-list args)
  ;;(display "check-arguments : pred-list=") (display pred-list) (newline)
  ;;(display "check-arguments : args=")(display args) (newline)
  (if (= (length pred-list) (length args))
      (let ((pred-arg-list (map cons pred-list args)))
	(every (lambda (p) ((car p) (cdr p)))
	;; replace every with every in Guile
	;;(every (lambda (p) ((car p) (cdr p)))
		pred-arg-list))
      #f))


;; args can be not the same number as predicates and their types must match 
(define (check-arguments-for-n-arity pred-list args)
  (define type (car pred-list)) ;; i suppose all predicate are same
  ;;(display "check-arguments-for-n-arity : type = ") (display type) (newline)
  ;;(display "check-arguments-for-n-arity : args = ") (display args) (newline)
  (define lbd-assign (lambda (arg) (cons type arg)))
  (define pred-arg-list (map lbd-assign args))
  (every (lambda (p) ((car p) (cdr p)))
	  ;; replace every with every in Guile
	  ;;(every (lambda (p) ((car p) (cdr p)))
	  pred-arg-list))
   





;; (define-overload-existing-procedure length orig-length)
;; > (overload length vector-length (vector?))
;; > (length #(1 2 3 4))
;; 4
;; > (length '(1 2 3))
;; 3
;; > (overload length string-length (string?))
;; length
;; > (length "abcde")
;; 5
(define-syntax define-overload-existing-procedure

  (syntax-rules ()

    ((_ proc orig-proc)

     (begin
       ;;(import (rename (overload) (proc orig-proc)))
       ;;(import (rename (gnu kawa) (proc orig-proc)))
       ;; (require (rename-in racket/base (proc
       ;; 				        orig-proc)))

       (define qproc (quote proc)) 
       
       (define (proc . args-lst)

	 ;;(display proc) (newline)
	 ;;(define ht (hash-table->alist $ovrld-ht$))
	 ;;(display ht) (newline)
	 (define proc-lst (hash-table-ref $ovrld-ht$ qproc)) ;;  example: ((number? string?) (lambda (n s) (display n) (display s) (newline)))
	 ;;(display proc-lst)
	 ;;(newline)
	 
	 (define (check-args-lst pred-list) ; check arguments list match predicates
	   (check-arguments pred-list args-lst))
	 
	 (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
	   (if (check-args-lst (car pred-proc-list))
	       (car (cdr  pred-proc-list))
	       #f))
	 
	 (define proc-search-result (any test-proc  proc-lst)) ; search for a procedure matching arguments
	 
	 (if proc-search-result
	     (apply proc-search-result args-lst)
	     (apply orig-proc args-lst)))
       
       (hash-table-set! $ovrld-ht$ qproc '())))))

      





;; > (define-overload-procedure area)
;; > (define (area-square x) (* x x))
;; > (area-square 4)
;; 16
;; > (hash-table->alist $ovrld-ht$)
;; '((#<procedure:area>))
;; > (overload area area-square (number?))
;; > (hash-table->alist $ovrld-ht$)
;; '((#<procedure:area> ((#<procedure:number?>) #<procedure:area-square>)))
;; > (area 2)
;; 4
;; > (define (area-rectangle x y) (* x y))
;; > (overload area area-rectangle (number? number?))
;; > (area 2 5)
;; 10

(define-syntax define-overload-procedure

  (syntax-rules ()

    ((_ proc)

     (begin

       (define qproc (quote proc)) 
       
       (define (proc . args-lst)
	 
	 (define proc-lst (hash-table-ref $ovrld-ht$ qproc)) ;;  return example: ((number? string?) (lambda (n s) (display n) (display s) (newline)))
	 ;;(display proc-lst)
	 ;;(newline)
	 
	 (define (check-args-lst pred-list) ; check arguments list match predicates
	   (check-arguments pred-list args-lst))
	 
	 (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
	   (if (check-args-lst (car pred-proc-list))
	       (car (cdr  pred-proc-list))
	       #f))
	 
	 (define proc-search-result (any test-proc  proc-lst)) ; search for a procedure matching arguments
	 
	 (if proc-search-result
	     (apply proc-search-result args-lst)
	     (error 'overload "failed because procedure ~a can not be applied to arguments list ~a" qproc args-lst)))
       
       (hash-table-set! $ovrld-ht$ qproc '()))))) 




(define-syntax define-overload-operator

  (syntax-rules ()

    ((_ proc)

     (begin

       (define qproc (quote proc)) 
       
       (define (proc . args-lst)
	 
	 (define proc-lst (hash-table-ref $ovrld-ht$ qproc)) ;;  example: ((number? string?) (lambda (n s) (display n) (display s) (newline)))
	 ;;(display proc-lst)
	 ;;(newline)
	 
	 (define (check-args-lst pred-list) ; check arguments list match predicates
	   (check-arguments pred-list args-lst))
	 
	 (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
	   (if (check-args-lst (car pred-proc-list))
	       (car (cdr  pred-proc-list))
	       #f))
	 
	 (define proc-search-result (any test-proc proc-lst)) ; search for a procedure matching arguments
	 
	 (condx  (proc-search-result (apply proc-search-result args-lst))
		 (exec
		  (define nb-args (length args-lst)))
		 ((> nb-args 2) (proc (car args-lst) (apply proc (cdr args-lst))))
		 (else (error 'overload "failed because procedure ~a can not be applied to arguments list ~a" qproc args-lst))))
       
       (hash-table-set! $ovrld-ht$ qproc '())

       )))) 





(define-syntax define-overload-n-arity-operator

  (syntax-rules ()

    ((_ proc)

     (begin

       (define qproc (quote proc)) 
       
       (define (proc . args-lst)
	 
	 (define proc-lst (hash-table-ref $ovrld-ht$ qproc)) ;;  example: ((number? string?) (lambda (n s) (display n) (display s) (newline)))
	 ;;(display proc-lst)
	 ;;(newline)
	 
	 (define (check-args-lst pred-list) ; check arguments list match predicates
	   ;;(or (check-arguments pred-list args-lst)  (check-arguments-for-n-arity  pred-list args-lst)))
	   (check-arguments-for-n-arity  pred-list args-lst)) ;;  this condition is more permissive than the above one
	 
	 (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
	   (if (check-args-lst (car pred-proc-list))
	       (car (cdr  pred-proc-list))
	       #f))
	 
	 (define proc-search-result (any test-proc  proc-lst)) ; search for a procedure matching arguments
	 
	 ;; (condx  (proc-search-result (apply proc-search-result args-lst))
	 ;; 	 (exec
	 ;; 	  (define nb-args (length args-lst)))
	 ;; 	 ((> nb-args 2) (proc (car args-lst) (apply proc (cdr args-lst))))
	 ;; 	 (else (error 'overload "failed because procedure ~a can not be applied to arguments list ~a" qproc args-lst))))

	 (if proc-search-result
	     (apply proc-search-result args-lst)
	     (error 'overload "failed because procedure ~a can not be applied to arguments list ~a" qproc args-lst)))
       
       (hash-table-set! $ovrld-ht$ qproc '()))))) 


;; overload tests

;; (display "before add-list-list") (newline)
;; (define (add-list-list v1 v2) (map + v1 v2))
;; (display "before overload") (newline)

;; (define-overload-existing-operator +)
;; (define-overload-existing-operator *)

;; (include "../Scheme-PLUS-for-Racket/main/Scheme-PLUS-for-Racket/required-files/scheme-infix.rkt")

;; (display infix-operators-lst) (newline)


;; overload tests



;; {ztest <+ 1}
;; (display "before test infix") (newline)
;; {3 * 5 + ztest}
;; {ztest <- 3 * 5 + ztest}

;;{t <+ {3 * '(1 2 3) + '(4 5 6) + '(7 8 9)}}
;;(display t) (newline)
(define-syntax define-overload-existing-operator

  (syntax-rules ()

    ((_ proc orig-proc)

     (begin

       ;;(import (rename (overload) (proc orig-proc)))
       ;;(require (rename-in racket/base (proc
       	;;			        orig-proc)))

       (display "define-overload-existing-operator : proc =") (display proc) (newline)
       (display "define-overload-existing-operator : orig-proc =") (display orig-proc) (newline)
       
       (define qproc (quote proc))  ; quoted operator
       
       (define (proc . args-lst) ; define operator

	 ;; (display "overload.scm : proc : $ovrld-ht$=")
	 ;; (display $ovrld-ht$)
	 ;; (newline)

	 ;; (display "overload.scm : proc : args-lst=")
	 ;; (display args-lst)
	 ;; (newline)


	 ;; get the list of procedure in the hash table for a given operator
	 (define proc-lst (hash-table-ref $ovrld-ht$ qproc)) ;;  example: ((number? string?) (lambda (n s) (display n) (display s) (newline)))
	 ;; (display "overload.scm : proc : proc-lst=") (display proc-lst)
	 ;; (newline)
	 
	 (define (check-args-lst pred-list) ; check arguments list match predicates
	   ;;(display "pred-list=") (display pred-list) (newline)
	   ;;(display "args-lst=") (display args-lst) (newline)
	   (check-arguments pred-list args-lst))



	 (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
	   ;;(display "pred-proc-list=") (display pred-proc-list) (newline)
	   (if (check-args-lst (car pred-proc-list)) ;; check args
	       (car (cdr  pred-proc-list)) ;; return procedure
	       #f))

	 
	 (define proc-search-result (any test-proc proc-lst)) ; search for a procedure matching arguments

	 
	 ;;(display "proc-search-result=") (display proc-search-result) (newline)
	 
	 (condx (proc-search-result (apply proc-search-result args-lst))
		(exec
		 (define nb-args (length args-lst)))
		((> nb-args 2)   ;;(display ">2 args") (newline)
		 (proc (car args-lst) (apply proc (cdr args-lst))))
		(else
		 ;;(display "else") (newline)
		 (apply orig-proc args-lst)))) ;; end proc
       
       ;;(hash-table-set! $ovrld-ht$ qproc (list (list (list number? number?) orig-proc)))
       (hash-table-set! $ovrld-ht$ qproc '())

       ;; (let ((tst-member (memq orig-proc (caddr infix-operators-lst))))
       ;; 	 (display "define-overload-existing-operator : tst-member orig-proc = ") (display tst-member) (newline))
       
       ;; (let ((tst-member (memq proc (caddr infix-operators-lst))))
       ;; 	 (display "define-overload-existing-operator : tst-member proc avant = ") (display tst-member) (newline))
       ;;(replace-operator! orig-proc proc)
       ;;(insert-operator! orig-proc proc)
       
       ;; (let ((tst-member (memq proc (caddr infix-operators-lst))))
       ;; 	 (display "define-overload-existing-operator : tst-member proc apres = ") (display tst-member) (newline))
       
       ))))



;; warning : all operators must be n-arity ,example: + for numbers is ,so if you wrote a + for lists ,you must provide it n-arity too, otherwise use overload for binary operators or another symbol than +,example +b for binary operators

(define-syntax define-overload-existing-n-arity-operator

  (syntax-rules ()

    ((_ proc  orig-proc)

     (begin

       ;;(require (rename-in racket/base (proc
       ;;				        orig-proc)))


       (define qproc (quote proc)) 
       
       (define (proc . args-lst)
	 
	 (define proc-lst (hash-table-ref $ovrld-ht$ qproc)) ;;  example: ((number? string?) (lambda (n s) (display n) (display s) (newline)))
	 ;;(display proc-lst)
	 ;;(newline)
	 
	 (define (check-args-lst pred-list) ; check arguments list match predicates
	   ;;(or (check-arguments pred-list args-lst)  (check-arguments-for-n-arity  pred-list args-lst)))
	   (check-arguments-for-n-arity  pred-list args-lst)) ;;  this condition is more permissive than the above one
	 
	 (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
	   (if (check-args-lst (car pred-proc-list))
	       (car (cdr  pred-proc-list))
	       #f))
	 
	 (define proc-search-result (any test-proc  proc-lst)) ; search for a procedure matching arguments
	 
	 ;; (condx  (proc-search-result (apply proc-search-result args-lst))
	 ;; 	 (exec
	 ;; 	  (define nb-args (length args-lst)))
	 ;; 	 ((> nb-args 2) (proc (car args-lst) (apply proc (cdr args-lst))))
	 ;; 	 (else
	 ;; 	  (apply orig-proc args-lst))))

	 (if proc-search-result
	     (apply proc-search-result args-lst)
	     (apply orig-proc args-lst)))
       
       (hash-table-set! $ovrld-ht$ qproc '())
       ;;(replace-operator! orig-proc proc)
       ;;(insert-operator! orig-proc proc)
       ))))





;; (overload-square-brackets vector-ref vector-set! (vector? number?))
;; > $ovrld-square-brackets-lst$
;; '(((vector? number?) (#<procedure:vector-ref> . #<procedure:vector-set!>)))

;; > matrix-vect?
;; #<procedure:matrix-vect?>
;; >  (overload-square-brackets matrix-vect-ref
;; 	 matrix-vect-set!  (matrix-vect? number? number?))
;; > $ovrld-square-brackets-lst$
;; '(((#<procedure:matrix-vect?> #<procedure:number?> #<procedure:number?>) (#<procedure:matrix-vect-ref> . #<procedure:matrix-vect-set!>)))
;; > (define Mv (matrix-vect #(#(1 2 3) #(4 5 6))))
;; > Mv
;; #<matrix-vect>
;; > (matrix-vect? Mv)
;; #t
;; > (find-getter-for-overloaded-square-brackets (list Mv 1 0))
;; #<procedure:matrix-vect-ref>
;; > {Mv[1 0]}
;; 4

;; >  (overload-square-brackets matrix-vect-ref matrix-vect-set!  (matrix-vect? number? number?))
;; > (define Mv (matrix-vect (vector (vector 1 2 3) (vector 4 5 6))))
;; > (matrix-vect-v Mv)
;; '#(#(1 2 3) #(4 5 6))
;; > {Mv[1 0] <- -7}
;; -7
;; > (matrix-vect-v Mv)
;; '#(#(1 2 3) #(-7 5 6))
;; > {Mv[1][0] <- 10}
;; . . ../../Scheme-PLUS-for-Racket/main/Scheme-PLUS-for-Racket/overload.rkt:820:13: $bracket-apply$: no matching found in $ovrld-square-brackets-lst$ : failed with those arguments list (#<matrix-vect> 1)
;; > (overload-square-brackets matrix-vect-line-ref matrix-vect-line-set! (matrix-vect? number?))
;; > {Mv[1][0] <- 10}
;; 10
;; > (matrix-vect-v Mv)
;; '#(#(1 2 3) #(10 5 6))

(define-syntax overload-square-brackets

  (syntax-rules ()

    ((_ getter setter (pred-arg pred-arg1 ...))   ;; getter setter and list of predicate to check the arguments

	(modify-$ovrld-square-brackets-lst$ (list (list pred-arg pred-arg1 ...)
						  (cons getter setter))))))


;; avoid: set!: cannot mutate module-required identifier in: $ovrld-square-brackets-lst$
(define (modify-$ovrld-square-brackets-lst$ arg)
  (set! $ovrld-square-brackets-lst$ (cons arg $ovrld-square-brackets-lst$)))


;; example, return : '(#<procedure:vector-ref> . #<procedure:vector-set!>)
(define (find-getter-and-setter-for-overloaded-square-brackets args-lst) 

  	 
	 (define (check-args-lst pred-list) ; check arguments list match predicates
	   (check-arguments pred-list args-lst))
	 
	 (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
	   (if (check-args-lst (car pred-proc-list))
	       (car (cdr  pred-proc-list))
	       #f))
	 
	 (define proc-search-result (any test-proc $ovrld-square-brackets-lst$ )) ; search for a procedure matching arguments
	 
	 (if proc-search-result
	     proc-search-result
	     (error '$bracket-apply$ "failed with those arguments list : ~a" args-lst)))
       

;; > (find-getter-for-overloaded-square-brackets '(#(1 2 3) 1))
;; #<procedure:vector-ref>
(define (find-getter-for-overloaded-square-brackets args-lst) 

  
  (define (check-args-lst pred-list) ; check arguments list match predicates
    ;;(display "check-args-lst : pred-list =") (display pred-list) (newline)
    (check-arguments pred-list args-lst))
	 
  (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
    ;;(display "test-proc : pred-proc-list =") (display pred-proc-list) (newline)
    (if (check-args-lst (car pred-proc-list))
	(car (cdr  pred-proc-list))
	#f))
  
  (define proc-search-result (any test-proc $ovrld-square-brackets-lst$ )) ; search for a procedure matching arguments

  ;;(display "find-getter-for-overloaded-square-brackets : args-lst = ") (display args-lst) (newline) (newline)
  
  (if proc-search-result
      (car proc-search-result)
      (error '$bracket-apply$ "no matching found in $ovrld-square-brackets-lst$ : failed with those arguments list ~a" args-lst)))



(define (find-setter-for-overloaded-square-brackets args-lst) 
	 
	 (define (check-args-lst pred-list) ; check arguments list match predicates
	   (check-arguments pred-list args-lst))
	 
	 (define (test-proc pred-proc-list) ; test the procedure if it matches with arguments
	   (if (check-args-lst (car pred-proc-list))
	       (car (cdr  pred-proc-list))
	       #f))
	 
	 (define proc-search-result (any test-proc $ovrld-square-brackets-lst$ )) ; search for a procedure matching arguments
	 
	 (if proc-search-result
	     (cdr proc-search-result)
	     (error '$bracket-apply$ "no matching found in $ovrld-square-brackets-lst$ : failed with those arguments list ~a" args-lst)))




) ; end module
