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


;;(library (syntax) ;; R6RS fail

(define-library (Scheme+ syntax-plus) ; R7RS

  (import (kawa base)
	  (srfi 1))

  (export datum=?  
	  member-syntax )


  ;; parse the representation of object to search for #<syntax something>
  ;; (define (check-syntax? obj)

  ;;   (let* ((str-obj (format #f "~s" obj))
  ;; 	 (lgt-str-obj (string-length str-obj))
  ;; 	 (str-syntax "#<syntax")
  ;; 	 (lgt-str-syntax (string-length str-syntax)))
  ;;     (and (> lgt-str-obj lgt-str-syntax) ; first, length greater
  ;; 	 (string=? (substring str-obj 0 lgt-str-syntax)
  ;; 		   str-syntax) ; begin by "#<syntax"
  ;; 	 (char=? #\> (string-ref str-obj (- lgt-str-obj 1)))))) ; last char is >

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



) ; end library


