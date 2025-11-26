(define-library (Scheme+ bitwise) ; R7RS

  (import (kawa base))

  (export << >>
	  &
	  ∣)


(define (<< x n)
  (ash x n))

(define (>> x n)
  (ash x (- n)))

(define & bitwise-and #;logand)
(define ∣ bitwise-ior #;logior) ;; pipe is not via mac keyboard but  this should be  U+2223
;(define ^ bitwise-xor #;logxor) ; TODO uncomment it to activate it
;(define ~ bitwise-not) 

) ; end module
