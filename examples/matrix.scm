(module-name "matrix")

(export multiply-matrix-matrix multiply-matrix-vector matrix matrix-v
 create-matrix-by-function dim-matrix matrix-ref matrix-set! matrix-line-ref
 matrix-line-set! vector->matrix-column matrix-column->vector)

(require Scheme+)

(require array)

(import (only (scheme base) (* orig*)))

(define-overload-existing-operator * orig*)

(define-simple-class matrix () (v :: vector)
 ((*init* (vParam :: vector)) (set! v vParam)))

(define (create-matrix-by-function fct lin col)
 (matrix (create-vector-2d fct lin col)))

(define (dim-matrix M)
 (when (not (matrix? M)) (error "argument is not of type matrix"))
 (<+ v (matrix-v M)) (<+ lin (vector-length v))
 (<+ col (vector-length ($bracket-apply$next v (list 0)))) (values lin col))

(define (multiply-matrix-matrix M1 M2) (<+ (n1 p1) (dim-matrix M1))
 (<+ (n2 p2) (dim-matrix M2))
 (when (≠ p1 n2)
  (error "matrix.* : matrix product impossible, incompatible dimensions"))
 (<+ v1 (matrix-v M1)) (<+ v2 (matrix-v M2))
 (define (res i j) (<+ sum 0)
  (for ((<+ k 0) (< k p1) (<- k (+ k 1)))
   (<- sum
    (+ sum
     (* ($bracket-apply$next ($bracket-apply$next v1 (list i)) (list k))
      ($bracket-apply$next ($bracket-apply$next v2 (list k)) (list j))))))
  sum)
 (<+ v (create-vector-2d res n1 p2)) (matrix v))

(overload-existing-operator * multiply-matrix-matrix (matrix? matrix?))

(define (matrix-v M) (slot-ref M (quote v)))

(define (vector->matrix-column v)
 (matrix (vector-map (lambda (x) (make-vector 1 x)) v)))

(define (matrix-column->vector Mc) (<+ v (matrix-v Mc))
 (vector-map (lambda (v2) ($bracket-apply$next v2 (list 0))) v))

(define (multiply-matrix-vector M v) (<+ Mc (vector->matrix-column v))
 (matrix-column->vector (* M Mc)))

(overload-existing-operator * multiply-matrix-vector (matrix? vector?))

(define (matrix-ref M lin col) (<+ v (matrix-v M))
 ($bracket-apply$next ($bracket-apply$next v (list lin)) (list col)))

(define (matrix-set! M lin col x) (<+ v (matrix-v M))
 (<- ($bracket-apply$next ($bracket-apply$next v (list lin)) (list col)) x))

(define (matrix-line-ref M lin) (<+ v (matrix-v M))
 ($bracket-apply$next v (list lin)))

(define (matrix-line-set! M lin vect-line) (<+ v (matrix-v M))
 (<- ($bracket-apply$next v (list lin)) vect-line))

(overload-square-brackets matrix-ref matrix-set! (matrix? number? number?))

(overload-square-brackets matrix-line-ref matrix-line-set! (matrix? number?))

