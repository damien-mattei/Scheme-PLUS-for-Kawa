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

;; (load "Scheme+.scm")

(require 'srfi-1)

;; try include , use include-relative if problems
(include "rec.scm") ; rec does  not exist in Kawa (no SRFI 31)
(include "def.scm")
(include "set-values-plus.scm")
(include "for_next_step.scm")
(include "declare.scm")
(include "condx.scm")
(include "block.scm")
(include "not-equal.scm")
(include "exponential.scm")
(include "while-do-when-unless.scm")
(include "repeat-until.scm")
(include "modulo.scm")
(include "bitwise.scm")


(include "slice.scm")

