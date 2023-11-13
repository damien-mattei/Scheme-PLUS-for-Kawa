;; Scheme+.scm

;; version 7.1

;; author: Damien MATTEI

;; location: France

;; Kawa version

;; Copyright 2021-2023 Damien MATTEI

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


(module-name Scheme+)

(require 'srfi-1)
(require 'srfi-69) ;; hash table

(require array)
(require for_next_step)
(require overload)
(require infix-operators)

(export def
	bracket-apply
	$
	for
	for-basic
	for-next
	for-basic/break
	for-basic/break-cont
	for/break-cont
	for-each-in
	in-range
	reversed
	<- ←
	-> →
	<+ ⥆
	+> ⥅
	declare
	$>
	$+>
	condx
	<> ≠
	**
	<v v>
	⇜ ⇝
	repeat
	%
	<< >>
	& ∣
	$nfx$ !*prec
	
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

	infix-operators-lst
	set-infix-operators-lst!
	replace-operator!)


;; try include , use include-relative-relative if problems
(include "rec.scm") ; rec does  not exist in Kawa (no SRFI 31)
(include "def.scm")
(include "set-values-plus.scm")
(include "increment.scm")
(include "declare.scm")
(include "condx.scm")
(include "block.scm")
(include "not-equal.scm")
(include "exponential.scm")
;;(include "while-do-when-unless.scm")
(include "repeat-until.scm")
(include "modulo.scm")
(include "bitwise.scm")

(include "slice.scm")

(include "scheme-infix.scm")

(include "assignment.scm")
(include "apply-square-brackets.scm")
