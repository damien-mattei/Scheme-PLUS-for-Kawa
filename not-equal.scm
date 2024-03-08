;; not equal operator for numbers

;; scheme@(guile-user)> (<> 1 2)
;; #t
;; scheme@(guile-user)> {1 <> 2}
;; #t
;; scheme@(guile-user)> {1 <> 1}
;; #f

;; should not be compatible with 'cut' (srfi 26)
(define (<> x y)
   (not (= x y)))

(define (≠ x y)
  (not (= x y)))
