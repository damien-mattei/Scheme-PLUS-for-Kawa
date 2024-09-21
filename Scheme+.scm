;; Scheme+.scm

;; version 9.4

;; author: Damien MATTEI

;; location: France

;; Kawa version

;; Copyright 2021-2024 Damien MATTEI

;; e-mail: damien.mattei@gmail.com

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

;; kawa -Dkawa.import.path=".:/Users/mattei/Scheme-PLUS-for-Kawa:"


;; use :

;;(import (Scheme+))
;; or :
;;(require Scheme+)


;;(module-name Scheme+)

(define-library (Scheme+) ; R7RS

  (import ;;(kawa base)
   ;;(only (scheme base) (do do-scheme)) ; only imports and rename do in do-scheme
   (rename (kawa base) (do do-scheme)
	               (if if-scheme)) ; standard imports and rename do in do-scheme
   (srfi 1) ; first ...
   (srfi 69); hash table
   (array)
   (for_next_step)
   (overload)

   (assignment)
   (bitwise)
   (block)
   (bracket-apply)
   (condx)
   (declare)
   (def)
   (exponential)
   (increment)
   (modulo)
   (nfx)
   (not-equal)
   (range)
   (repeat-until)
   (slice)
   (while-do)
   (if-then-else)) ; end import

 


(export def
	bracket-apply
	;;$bracket-apply$next
	: ;; $  see slice.scm
	for
	for-basic
	for-next
	for-basic/break
	for-basic/break-cont
	for/break-cont
	for-each-in
	in-range
	reversed
	<- ← :=
	-> →
	<+ ⥆ :+
	+> ⥅
	declare
	$>
	$+>
	begin-def
	condx
	<> ;; should not be compatible with 'cut' (srfi 26)
	≠
	**
	<v v>
	⇜ ⇝
	repeat while do
	if
	%
	<< >>
	& ∣
	$nfx$ ;;!*prec
	
	$ovrld-ht$
	
	define-overload-procedure
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

	;;overload-function

	;;$ovrld-square-brackets-lst$
	
	overload-square-brackets
	;;find-getter-and-setter-for-overloaded-square-brackets
	find-getter-for-overloaded-square-brackets
	find-setter-for-overloaded-square-brackets

	;;infix-operators-lst
	;;set-infix-operators-lst!
	;;replace-operator!
	;;insert-operator!

	) ; end export



) ; end module


