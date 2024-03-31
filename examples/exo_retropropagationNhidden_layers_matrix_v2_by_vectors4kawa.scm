(require matrix)

(require Scheme+)

(require array)

(import (only (scheme base) (+ orig+) (* orig*)))

(define-overload-existing-operator * orig*)

(define-overload-existing-operator + orig+)

(define-overload-procedure random)

(define (random-int n) (integer (* n (random))))

(overload-existing-operator * multiply-matrix-matrix (matrix? matrix?))

(overload-existing-operator * multiply-matrix-vector (matrix? vector?))

(insert-operator! orig* *)

(overload-existing-operator + vector-append (vector? vector?))

(insert-operator! orig+ +)

(overload-procedure random java.lang.Math:random ())

(overload-procedure random random-int (integer?))

(define (uniform-dummy dummy1 dummy2) (+ -1 (* (random) 2)))

(define (uniform-interval inf sup) (<+ gap (- sup inf))
 (+ inf (* gap (random))))

(define (σ z̃) (/ 1 (+ 1 (exp (- z̃)))))

(define (der_tanh z z̃) (- 1 (** z 2)))

(define (der_σ z z̃) (* z (- 1 z)))

(define (der_atan z z̃) (/ 1 (+ 1 (** z̃ 2))))

(define
 (modification_des_poids M_i_o η z_input z_output z̃_output ᐁ_i_o
  მzⳆმz̃)
 (<+ (len_layer_output len_layer_input_plus1forBias) (dim-matrix M_i_o))
 (<+ len_layer_input (- len_layer_input_plus1forBias 1))
 (for-each-in (j (in-range len_layer_output))
  (for-each-in (i (in-range len_layer_input))
   (<- ($bracket-apply$next M_i_o (list j (+ i 1)))
    (- ($bracket-apply$next M_i_o (list j (+ i 1)))
     (* (- η) ($bracket-apply$next z_input (list i))
      (მzⳆმz̃ ($bracket-apply$next z_output (list j))
       ($bracket-apply$next z̃_output (list j)))
      ($bracket-apply$next ᐁ_i_o (list j))))))
  (<- ($bracket-apply$next M_i_o (list j 0))
   (- ($bracket-apply$next M_i_o (list j 0))
    (* (- η) 1.0
     (მzⳆმz̃ ($bracket-apply$next z_output (list j))
      ($bracket-apply$next z̃_output (list j)))
     ($bracket-apply$next ᐁ_i_o (list j)))))))

(define-simple-class ReseauRetroPropagation () (nbiter init-value: 3)
 (activation_function_hidden_layer) (activation_function_output_layer)
 (activation_function_hidden_layer_derivative)
 (activation_function_output_layer_derivative) (ηₛ 1.0) (z) (z̃) (M) (ᐁ)
 (eror 0)
 ((*init* nc nbiter0 ηₛ0 activation_function_hidden_layer0
   activation_function_output_layer0
   activation_function_hidden_layer_derivative0
   activation_function_output_layer_derivative0)
  (display "*init* : nc=") (display nc) (newline) (<- nbiter nbiter0)
  (<- ηₛ ηₛ0)
  (<- activation_function_hidden_layer activation_function_hidden_layer0)
  (<- activation_function_output_layer activation_function_output_layer0)
  (<- activation_function_hidden_layer_derivative
   activation_function_hidden_layer_derivative0)
  (<- activation_function_output_layer_derivative
   activation_function_output_layer_derivative0)
  (<+ lnc (vector-length nc)) (define (make-vector-z lg) (make-vector lg 0))
  (<- z (vector-map make-vector-z nc)) (display "z=") (display z) (newline)
  (<- z̃ (vector-map make-vector-z nc)) (display "z̃=") (display z̃)
  (newline)
  (<- M
   (vector-map
    (lambda (n)
     (create-matrix-by-function uniform-dummy
      ($bracket-apply$next nc (list (+ n 1)))
      (+ ($bracket-apply$next nc (list n)) 1)))
    ($bracket-list$ 0 <: (- lnc 1))))
  (display "M=") (display M) (newline) (<- ᐁ (vector-map make-vector-z nc))
  (display "ᐁ=") (display ᐁ) (newline) (display "nbiter=") (display nbiter)
  (newline))
 ((accepte_et_propage x)
  (when
   (≠ (vector-length x) (vector-length ($bracket-apply$next z (list 0))))
   (display "Mauvais nombre d'entrées !") (newline) (exit #f))
  (<- ($bracket-apply$next z (list 0)) x) (<+ n (vector-length z))
  (declare z_1) (declare i)
  (for ((<- i 0) (< i (- n 2)) (<- i (+ i 1)))
   (<- z_1 (+ #(1) ($bracket-apply$next z (list i))))
   (<- ($bracket-apply$next z̃ (list (+ i 1)))
    (* ($bracket-apply$next M (list i)) z_1))
   (<- ($bracket-apply$next z (list (+ i 1)))
    (vector-map activation_function_hidden_layer
     ($bracket-apply$next z̃ (list (+ i 1))))))
  (<- z_1 (+ #(1) ($bracket-apply$next z (list i))))
  (<- ($bracket-apply$next z̃ (list (+ i 1)))
   (* ($bracket-apply$next M (list i)) z_1))
  (<- ($bracket-apply$next z (list (+ i 1)))
   (vector-map activation_function_output_layer
    ($bracket-apply$next z̃ (list (+ i 1))))))
 ((apprentissage Lexemples) (<+ ip 0) (declare x y)
  (for-each-in (it (in-range nbiter))
   (when (= (% it 1000) 0) (display it) (newline))
   (<- (x y) ($bracket-apply$next Lexemples (list ip))) (accepte_et_propage x)
   (<+ i i_output_layer (- (vector-length z) 1))
   (<+ ns (vector-length ($bracket-apply$next z (list i))))
   (for-each-in (k (in-range ns))
    (<- ($bracket-apply$next ($bracket-apply$next ᐁ (list i)) (list k))
     (- ($bracket-apply$next y (list k))
      ($bracket-apply$next ($bracket-apply$next z (list i)) (list k)))))
   (<+ მzⳆმz̃ activation_function_output_layer_derivative)
   (modification_des_poids ($bracket-apply$next M (list (- i 1))) ηₛ
    ($bracket-apply$next z (list (- i 1))) ($bracket-apply$next z (list i))
    ($bracket-apply$next z̃ (list i)) ($bracket-apply$next ᐁ (list i))
    მzⳆმz̃)
   (<- მzⳆმz̃ activation_function_hidden_layer_derivative)
   (for-each-in (i (reversed (in-range 1 i_output_layer)))
    (<+ nc (vector-length ($bracket-apply$next z (list i))))
    (<+ ns (vector-length ($bracket-apply$next z (list (+ i 1)))))
    (for-each-in (j (in-range nc))
     (<- ($bracket-apply$next ($bracket-apply$next ᐁ (list i)) (list j))
      ($+> (<+ sum 0)
       (for-each-in (k (in-range ns))
        (<- sum
         (+ sum
          (*
           (მzⳆმz̃
            ($bracket-apply$next ($bracket-apply$next z (list (+ i 1)))
             (list k))
            ($bracket-apply$next ($bracket-apply$next z̃ (list (+ i 1)))
             (list k)))
           ($bracket-apply$next ($bracket-apply$next M (list i))
            (list k (+ j 1)))
           ($bracket-apply$next ($bracket-apply$next ᐁ (list (+ i 1)))
            (list k))))))
       sum)))
    (modification_des_poids ($bracket-apply$next M (list (- i 1))) ηₛ
     ($bracket-apply$next z (list (- i 1))) ($bracket-apply$next z (list i))
     ($bracket-apply$next z̃ (list i)) ($bracket-apply$next ᐁ (list i))
     მzⳆმz̃))
   (<- ip (random (vector-length Lexemples)))))
 ((test Lexemples) (display "Test des exemples :") (newline) (<+ err 0)
  (declare entree sortie_attendue ᐁ)
  (for-each-in (entree-sortie_attendue Lexemples)
   (<- (entree sortie_attendue) entree-sortie_attendue)
   (accepte_et_propage entree)
   (format #t "~a --> ~a : on attendait ~a~%" entree
    ($bracket-apply$next z (list (- (vector-length z) 1))) sortie_attendue)
   (<- ᐁ
    (- ($bracket-apply$next sortie_attendue (list 0))
     ($bracket-apply$next
      ($bracket-apply$next z (list (- (vector-length z) 1))) (list 0))))
   (<- err (+ err (** ᐁ 2))))
  (<- err (* err 0.5)) (display "Error on examples=") (display err) (newline)))

(display "################## NOT ##################")

(newline)

(<+ r1 (ReseauRetroPropagation #(1 2 1) 5000 10 σ σ der_σ der_σ))

(<+ Lexemples1 #((#(1) . #(0)) (#(0) . #(1))))

(r1:apprentissage Lexemples1)

(r1:test Lexemples1)

(newline)

(display "################## XOR ##################")

(newline)

(<+ r2 (ReseauRetroPropagation #(2 8 1) 250000 0.1 σ σ der_σ der_σ))

(<+ Lexemples2
 #((#(1 0) . #(1)) (#(0 0) . #(0)) (#(0 1) . #(1)) (#(1 1) . #(0))))

(r2:apprentissage Lexemples2)

(r2:test Lexemples2)

(newline)

(display "################## SINE ##################")

(newline)

(<+ r3
 (ReseauRetroPropagation #(1 70 70 1) 50000 0.01 atan tanh der_atan der_tanh))

(declare pi)

(<- pi (* 4 (atan 1)))

(<+ Llearning
 (vector-map (lambda (x) (cons (vector x) (vector (sin x))))
  (list->vector
   (map (lambda (n) (uniform-interval (- pi) pi)) (in-range 10000)))))

(<+ Ltest
 (vector-map (lambda (x) (cons (vector x) (vector (sin x))))
  (list->vector
   (map (lambda (n) (uniform-interval (/ (- pi) 2) (/ pi 2)))
    (in-range 10000)))))

(r3:apprentissage Llearning)

(r3:test Ltest)

(newline)

