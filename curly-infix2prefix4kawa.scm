#!/usr/bin/env kawa
;;#!/opt/homebrew/bin/kawa

;; infix parser/optimizer with precedence operator by Damien Mattei


;; Copyright (C) 2012 David A. Wheeler and Alan Manuel K. Gloria. All Rights Reserved.

;; Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;; modification for Kawa by Damien Mattei

;; use with: kawa curly-infix2prefix4kawa.scm  file2parse.scm

;; or simply:
;; curly-infix2prefix4kawa.scm  file2parse.scm
;; if the file is executable

;; example: kawa curly-infix2prefix4kawa.scm   ../AI_Deep_Learning/kawa/matrix+.scm | tr -d '|' > ../AI_Deep_Learning/kawa/matrix.scm

;; kawa curly-infix2prefix4kawa.scm  ../AI_Deep_Learning/exo_retropropagationNhidden_layers_matrix_v2_by_vectors4kawa+.scm | tr -d '|' > ../AI_Deep_Learning/exo_retropropagationNhidden_layers_matrix_v2_by_vectors4kawa.scm

;; options:

;; --verbose

;; --kawa : try to parse a code mixing both Kawa range syntax <:  and Scheme+ slicing syntax :

;;(require 'srfi-1) ;; for 'third' ...

(define rest cdr)


(define stderr (current-error-port))


(include "SRFI-105.scm")


;;(import (kawa pprint))


;;(define srfi-105 #f)

;; quiet mode that do not display on standart error the code
(define verbose #f)


(define (literal-read-syntax src)

  (define in (open-input-file src))
  (define lst-code (process-input-code-tail-rec in))
  lst-code)
 

;; read all the expression of program
;; DEPRECATED (replaced by tail recursive version)
;; (define (process-input-code-rec in)
;;   (define result (curly-infix-read in))  ;; read an expression
;;   (if (eof-object? result)
;;       '()
;;       (cons result (process-input-code-rec in))))


;; read all the expression of program
;; a tail recursive version
(define (process-input-code-tail-rec in) ;; in: port


  (when verbose
	(display "SRFI-105 Curly Infix parser with operator precedence by Damien MATTEI" stderr) (newline stderr)
	(display "(based on code from David A. Wheeler and Alan Manuel K. Gloria.)" stderr) (newline stderr) (newline stderr)
	
	;; (when srfi-105
	;;       (display "SRFI-105 strict compatibility mode is ON." stderr))
	;; (newline stderr)

	(newline stderr) 

	;;(display slice-optim stderr) (newline stderr) 
  
	(display "Parsed curly infix code result = " stderr) (newline stderr) (newline stderr))
  
  (define (process-input acc)
    
    (define result (curly-infix-read in))  ;; read an expression


    (when verbose
	  ;;(display (write result stderr) stderr) ;; without 'write' string delimiters disappears !
	  ;;(display result stderr)
	  (write result stderr)
	  (newline stderr)
	  (newline stderr))
    
    (if (eof-object? result)
	(reverse acc)
	(process-input (cons result acc))))
  
  (process-input '()))


  

; parse the input file from command line
(define cmd-ln (command-line))
;;(format #t "The command-line was:~{ ~w~}~%" cmd-ln)
;;(display "cmd-ln=") (display cmd-ln) (newline)

(define options (cdr cmd-ln))
;;(display "options= ") (display options) (newline)

(when (member "--help" options)
      (display "curly-infix2prefix4kawa.scm documentation: (see comments in source file for more examples)") (newline) (newline) 
      (display "kawa curly-infix2prefix4kawa.scm [options] file2parse.scm") (newline) (newline)
      (display "options:") (newline)(newline)
;;      (display "  --srfi-105 : set strict compatibility mode with SRFI-105 ") (newline) (newline)
      (display "  --kawa : try to parse a code mixing both Kawa range syntax and Scheme+ slicing syntax ") (newline) (newline)
      (display "  --verbose : display code on stderr too ") (newline) (newline)
      (exit))

;; SRFI-105 strict compatibility option
;; (when (member "--srfi-105" options)
;;       (set! nfx-optim #f)
;;       (set! slice-optim #f))

(when (member "--kawa" options)
      (set! kawa-compat #t))

(when (member "--verbose" options)
      (set! verbose #t))


(define file-name (car (reverse cmd-ln)))

(when (string=? (substring file-name 0 2) "--")
      (error "filename start with -- ,this is confusing with options."))

(define code-lst (literal-read-syntax file-name))

;; (define (dspp-expr expr)
;;   (pprint (write expr))
;;   (newline))



(define (wrt-expr expr)
  (write expr) ;; without 'write' string delimiters disappears !
  (newline)
  (newline))


(for-each wrt-expr code-lst)


