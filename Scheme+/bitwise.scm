(define-library (Scheme+ bitwise) ; R7RS

  (import (kawa base))

  (export << >>
	  &
	  ∣)


(define (<< x n)
  (ash x n))

(define (>> x n)
  (ash x (- n)))

(define & logand)
(define ∣ logior) ;; pipe is not via mac keyboard but  this should be  U+2223


) ; end module
