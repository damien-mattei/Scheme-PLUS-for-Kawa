(require Scheme+)

(require (quote srfi-1))

(include "../rest.scm")

(define (one? n) (= n 1))

(declare L-init t-init ls dyna cpt)

(<- L-init
 (quote
  (1 3 4 16 17 24 45 64 197 256 275 323 540 723 889 915 1040 1041 1093 1099
   1111 1284 1344 1520 2027 2500 2734 3000 3267 3610 4285 5027)))

(<- t-init 35267)

(<- ls (length L-init))

(<- dyna (make-array (shape 0 (+ ls 1) 0 (+ t-init 1)) 0))

(define (tf->12 b) (if b 1 2))

(<- cpt 0)

(define (ssigma-dyna-define-anywhere L t) (<- cpt (+ cpt 1)) (<+ ls (length L))
 (<+ dyn ($bracket-apply$next dyna (list ls t))) (def c) (def R)
 (one?
  (if (not (zero? dyn)) dyn
   ($>
    (<- ($bracket-apply$next dyna (list ls t))
     (tf->12
      (if (null? L) #f
       ($> (<- c (first L)) (<- R (rest L))
        (cond ((= c t) #t) ((> c t) (ssigma-dyna-define-anywhere R t))
         (else
          (or (ssigma-dyna-define-anywhere R (- t c))
           (ssigma-dyna-define-anywhere R t))))))))
    ($bracket-apply$next dyna (list ls t))))))

(define (ssigma-dyna-def L t) (display L) (newline) (display t) (newline)
 (newline) (<- cpt (+ cpt 1)) (def (ls dyn)) (<- ls (length L))
 (<- dyn ($bracket-apply$next dyna (list ls t))) (def c) (def R)
 (one?
  (if (not (zero? dyn)) dyn
   ($>
    (<- ($bracket-apply$next dyna (list ls t))
     (tf->12
      (if (null? L) #f
       ($> (<- c (first L)) (<- R (rest L))
        (cond ((= c t) #t) ((> c t) (ssigma-dyna-def R t))
         (else (or (ssigma-dyna-def R (- t c)) (ssigma-dyna-def R t))))))))
    ($bracket-apply$next dyna (list ls t))))))

(define (ssigma-proto L t) (set! cpt (+ cpt 1)) (define ls (length L))
 (define dyn (array-ref dyna ls t))
 (cond ((not (zero? dyn)) (one? dyn)) ((null? L) (array-set! dyna 2 ls t) #f)
  (else
   (let ((c (first L)))
    (if (= c t) (begin (array-set! dyna 1 ls t) #t)
     (let ((R (rest L)))
      (if (> c t)
       (let ((s (ssigma-proto R t))) (array-set! dyna (tf->12 s) ls t) s)
       (let ((s (or (ssigma-proto R (- t c)) (ssigma-proto R t))))
        (array-set! dyna (tf->12 s) ls t) s))))))))

(define (ssigma-proto-condx L t) (set! cpt (+ cpt 1)) (define ls (length L))
 (define dyn (array-ref dyna ls t)) (display L) (newline) (display t) (newline)
 (condx ((not (zero? dyn)) (one? dyn)) ((null? L) (array-set! dyna 2 ls t) #f)
  (exec (define c (first L))) ((= c t) (array-set! dyna 1 ls t) #t)
  (exec (define R (rest L)))
  ((> c t) (define s (ssigma-proto-condx R t))
   (array-set! dyna (tf->12 s) ls t) s)
  (else (define s (or (ssigma-proto-condx R (- t c)) (ssigma-proto-condx R t)))
   (array-set! dyna (tf->12 s) ls t) s)))

(def (subset-sum-dyna L t) (declare ls dyn) (<- ls (length L))
 (<- dyn ($bracket-apply$next dyna (list ls t)))
 (when (<> dyn 0) (return (one? dyn)))
 (when (null? L) (<- ($bracket-apply$next dyna (list ls t)) 2) (return #f))
 (<+ c (first L))
 (when (= c t) (<- ($bracket-apply$next dyna (list ls t)) 1) (return #t))
 (<+ R (rest L)) (declare s)
 (if (> c t) (<- s (subset-sum-dyna R t))
  (<- s (or (subset-sum-dyna R (- t c)) (subset-sum-dyna R t))))
 (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)

(def (subset-sum-dynamic L t) (declare ls dyn c R s) (<- ls (length L))
 (<- dyn ($bracket-apply$next dyna (list ls t)))
 (when (<> dyn 0) (return (one? dyn)))
 (when (null? L) (<- ($bracket-apply$next dyna (list ls t)) 2) (return #f))
 (<- c (first L))
 (when (= c t) (<- ($bracket-apply$next dyna (list ls t)) 1) (return #t))
 (<- R (rest L))
 (if (> c t) (<- s (subset-sum-dynamic R t))
  (<- s (or (subset-sum-dynamic R (- t c)) (subset-sum-dynamic R t))))
 (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)

(def (subset-sum-dynamic-new-syntax L t) (declare ls dyn c R s)
 (<- ls (length L)) (<- dyn ($bracket-apply$next dyna (list ls t)))
 (when (<> dyn 0) (return (one? dyn)))
 (when (null? L) (<- ($bracket-apply$next dyna (list ls t)) 2) (return #f))
 (<- c (first L))
 (when (= c t) (<- ($bracket-apply$next dyna (list ls t)) 1) (return #t))
 (<- R (rest L))
 (if (> c t) (let () (<- s (subset-sum-dynamic-new-syntax R t)))
  (let ()
   (<- s
    (or (subset-sum-dynamic-new-syntax R (- t c))
     (subset-sum-dynamic-new-syntax R t)))))
 (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)

(define (subset-sum-condx L t) (declare ls dyn) (<- ls (length L))
 (<- dyn ($bracket-apply$next dyna (list ls t)))
 (condx ((<> dyn 0) (one? dyn))
  ((null? L) (<- ($bracket-apply$next dyna (list ls t)) 2) #f)
  (exec (<+ c (first L)))
  ((= c t) (<- ($bracket-apply$next dyna (list ls t)) 1) #t)
  (exec (<+ R (rest L)))
  ((> c t) (<+ s (subset-sum-condx R t))
   (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)
  (else (<+ s (or (subset-sum-condx R (- t c)) (subset-sum-condx R t)))
   (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)))

(define (subset-sum L t) (<+ ls (length L))
 (<+ dyn ($bracket-apply$next dyna (list ls t))) (<- cpt (+ cpt 1))
 (condx ((<> dyn 0) (one? dyn))
  ((null? L) (<- ($bracket-apply$next dyna (list ls t)) 2) #f)
  (exec (<+ c (first L)))
  ((= c t) (<- ($bracket-apply$next dyna (list ls t)) 1) #t)
  (exec (<+ R (rest L)))
  ((> c t) (<+ s (subset-sum R t))
   (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)
  (else (<+ s (or (subset-sum R (- t c)) (subset-sum R t)))
   (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)))

(define (subset-sum-dec L t) (declare ls dyn c R s) (<- ls (length L))
 (<- dyn ($bracket-apply$next dyna (list ls t))) (<- cpt (+ cpt 1))
 (condx ((<> dyn 0) (one? dyn))
  ((null? L) (<- ($bracket-apply$next dyna (list ls t)) 2) #f)
  (exec (<- c (first L)))
  ((= c t) (<- ($bracket-apply$next dyna (list ls t)) 1) #t)
  (exec (<- R (rest L)))
  ((> c t) (<- s (subset-sum-dec R t))
   (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)
  (else (<- s (or (subset-sum-dec R (- t c)) (subset-sum-dec R t)))
   (<- ($bracket-apply$next dyna (list ls t)) (tf->12 s)) s)))

(define (subset-sum-value L t) (declare ls dyn c R s) (<- ls (length L))
 (<- dyn ($bracket-apply$next dyna (list ls t))) (<- cpt (+ cpt 1))
 (condx ((not (equal? dyn 0)) dyn)
  ((null? L) (<- ($bracket-apply$next dyna (list ls t)) #f) #f)
  (exec (<- c (first L)))
  ((= c t) (<- s ($bracket-apply$next dyna (list ls t)) (list c)) s)
  (exec (<- R (rest L)))
  ((> c t) (<- s (subset-sum-value R t))
   (<- ($bracket-apply$next dyna (list ls t)) s) s)
  (exec (<- s (subset-sum-value R (- t c))))
  (s (<- s ($bracket-apply$next dyna (list ls t)) (cons c s)) s)
  (exec (<- s (subset-sum-value R t)))
  (else (<- ($bracket-apply$next dyna (list ls t)) s) s)))

