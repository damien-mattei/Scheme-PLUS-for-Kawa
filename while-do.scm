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

(define-library (while-do) ; R7RS

  (import ;;(kawa base))
   (rename (kawa base) (do do-scheme)) ; standard imports and rename do in do-scheme
   ) ; end import
   
  (export do
	  while)


;; warning: 'do is already part of R6RS (reserved keyword) 'while is not in R5RS,R6RS, R7RS-small

;; but 'do in Scheme has a painful syntax

;; syntax defined in this file are inspired from Pascal language

;; scheme@(guile-user)> (use-modules (Scheme+))
;; scheme@(guile-user)> (define i 0)
;; scheme@(guile-user)> (define do '())
;; scheme@(guile-user)> (while {i < 4}
;;                           do
;;                              (display i)
;;                              (newline)
;;                              {i <- {i + 1}})
;; 0
;; 1
;; 2
;; 3
;; $1 = #f

;; (while {i < 4}
;;    do
;;      (display i)
;;      (newline)
;;      {i <- {i + 1}})

;; (define-syntax while
;;   (syntax-rules (while do)
;;     ((_ pred do b1 ...)
;;      (let loop () (when pred b1 ... (loop))))))

;; (do ((i 1 (1+ i))
;;      (p 3 (* 3 p)))
;;     ((> i 4)
;;      p)
;;   (format #t "3**~s is ~s\n" i p))
;; 3**1 is 3
;; 3**2 is 9
;; 3**3 is 27
;; 3**4 is 81
;; $1 = 243

;; scheme@(guile-user)> (do ((i 1 (1+ i))
;;      (p 3 (* 3 p)))
;;     ((> i 4)
;;      p)
;;   (set! p (+ p i)))
;; $1 = 417


;; with a definition inside only the new version works:
;; (do ((i 1 (+ 1 i))
;;      (p 3 (* 3 p)))
;;     ((> i 4)
;;      p)
;;   (define x 7)
;;   (set! p (+ p i x)))
;; $3 = 1257


;; 'do is redefined here only to allow 'define in body as allowed in Scheme+
;; (define-syntax do

;;   (syntax-rules ()

;;     ((do ((var init step ...) ...)

;;          (test expr ...)

;;          command ...)

;;      (letrec

;;        ((loop

;;          (lambda (var ...)

;;            (if test

;;                ;;(begin
;; 	       (let ()

;;                  ;;#f ; avoid empty begin but with (let () i don't care !
;; 		 '() ;; avoid while-do-when-unless.scm: let: bad syntax (missing binding pairs or body) in: (let ())
;;                  expr ...)

;;                ;;(begin
;; 	       (let ()

;;                  command

;;                  ...

;;                  (loop (do "step" var step ...)

;;                        ...))))))

;;        (loop init ...)))

;;     ((do "step" x)

;;      x)

;;     ((do "step" x y)

;;      y)))


;; already exit in kawa 
;; ;; definitions redefined here only to allow 'define in body as allowed in Scheme+
;; (define-syntax when
;;   (syntax-rules ()
;;     ;;((when test result1 result2 ...)
;;     ((when test result1  ...)
;;      (if test
;;          ;;(begin result1 result2 ...)))))
;; 	 ;;(let () result1 result2 ...)))))
;; 	 (let () result1 ...)))))

;; (define-syntax unless
;;   (syntax-rules ()
;;     ;;((unless test result1 result2 ...)
;;     ((unless test result1 ...)
;;      (if (not test)
;;          ;;(begin result1 result2 ...)))))
;; 	 ;;(let () result1 result2 ...)))))
;; 	 (let () result1 ...)))))




;; #|kawa:2|# (define i 0)
;; #|kawa:3|# (do  (define j i)  (display "toto") (newline) (set! i (+ i 1)) while (< j 4)) 
;; toto
;; toto
;; toto
;; toto
;; toto
;; #|kawa:4|# (do ((i 1 (+ i 1)) (p 3 (* 3 p))) ((> i 4) p)(display p)(newline))
;; 3
;; 9
;; 27
;; 81
;; 243

;; #|kawa:5|# (define i 0) 
;; #|kawa:6|# (do (display "toto") (newline) (set! i (+ i 1)) while (< i 4)) 
;; toto
;; toto
;; toto
;; toto

(define-syntax do
  (syntax-rules (while)

    ((do ((variable init step ...) ...) (test expr ...) body ...)
     (do-scheme ((variable init step ...) ...) (test expr ...) body ...))
    
    ((do b1 ...
       while pred)
     (let loop () b1 ... (when pred (loop))))))




;; #|kawa:2|# (define x 0)
;; #|kawa:3|# (while (< x 10)
;; #|.....4|#           (define y x)  
;; #|.....5|#             (display y)
;; #|.....6|#             (newline)
;; #|.....7|#             (set! x (+ x 1)))
;; 0
;; 1
;; 2
;; 3
;; 4
;; 5
;; 6
;; 7
;; 8
;; 9

(define-syntax while
  (syntax-rules ()

    ((while condition body ...) (let loop ()
			     (when condition
				   body ...
				   (loop))))))


) ; end module

