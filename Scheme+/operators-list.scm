;; This file is part of Scheme+

;; Copyright 2024 Damien MATTEI

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

(define-library (Scheme+ operators-list) ; R7RS

  (import
      (kawa base))
  
  (export definition-operator
	  assignment-operator
	  
	  infix-operators-lst-for-parser
	  
	  definition-operator-syntax
	  assignment-operator-syntax
	  
	  infix-operators-lst-for-parser-syntax
	  get-infix-operators-lst-for-parser-syntax ; for Kawa
	  
	  operators-lst
	  operators-lst-syntax)


(define definition-operator (list '<+ '+>
				  '⥆ '⥅
				  ':+ '+:))

(define assignment-operator (list '<- '->
				  '← '→
				  ':=  '=:
				  '<v 'v>
				  '⇜ '⇝))


(define infix-operators-lst-for-parser

  (list
    
   (list 'expt '**)
   (list '* '/ '%)
 
   (list '+ '-)
   
   (list '<< '>>)
   
   (list '&)
   (list '^)
   (list '∣)
   
   (list '< '> '= '≠ '<= '>= '<>)

   (list 'and)
   
   (list 'or)
    
   (append assignment-operator 
	   definition-operator)
     
   )
  
  )



;; some comments because i do not understand (kawa incompatibility) this output:
;; !0-generic : operator-precedence=((#<syntax#331 expt in #728>
;;                                    #<syntax#332 ** in #729>)
;;                                   (#<syntax#333 * in #730>
;;                                    #<syntax#334 / in #731>
;;                                    #<syntax#335 % in #732>)
;;                                   (#<syntax#336 + in #733>
;;                                    #<syntax#337 - in #734>)
;;                                   (#<syntax#338 << in #735>
;;                                    #<syntax#339 >> in #736>)
;;                                   (#<syntax#340 & in #737>
;;                                    #<syntax#341 ∣ in #738>)
;;                                   (#<syntax#342 < in #739>
;;                                    #<syntax#343 > in #740>
;;                                    #<syntax#344 = in #741>
;;                                    #<syntax#345 ≠ in #742>
;;                                    #<syntax#346 <= in #743>
;;                                    #<syntax#347 >= in #744>
;;                                    #<syntax#348 <> in #745>)
;;                                   (#<syntax#349 and in #746>)
;;                                   (#<syntax#350 or in #747>)
;;                                   (#<syntax#322 <- in #718>
;;                                    #<syntax#323 -> in #719>
;;                                    #<syntax#324 ← in #720>
;;                                    #<syntax#325 → in #721>
;;                                    #<syntax#326 := in #722> =:
;;                                    #<syntax#327 <v in #724>
;;                                    #<syntax#328 v> in #725>
;;                                    #<syntax#329 ⇜ in #726>
;;                                    #<syntax#330 ⇝ in #727>)
;;                                   (#<syntax#317 <+ in #712>
;;                                    #<syntax#318 +> in #713>
;;                                    #<syntax#319 ⥆ in #714>
;;                                    #<syntax#320 ⥅ in #715>
;;                                    #<syntax#321 :+ in #716> +:))


(define definition-operator-syntax (list #'<+ #'+>
					 #'⥆ #'⥅
					 #':+ ;;(syntax +:) ;#'+:
					 ))

(define assignment-operator-syntax (list #'<- #'->
					 #'← #'→
					 #':= ;;(syntax =:) ;#'=:
					 #'<v #'v>
					 #'⇜ #'⇝))



(define infix-operators-lst-for-parser-syntax

  (list
    (list #'expt #'**)
    (list #'* #'/ #'%)
    (list #'+ #'-)
	
    (list #'<< #'>>)

    (list #'& #'∣)

    (list #'< #'> #'= #'≠ #'<= #'>= #'<>)

    (list #'and)

    (list #'or)

    assignment-operator-syntax
    definition-operator-syntax 
    )

  )


(define (get-infix-operators-lst-for-parser-syntax)
  infix-operators-lst-for-parser-syntax)



;; liste à plate des operateurs
(define operators-lst
  (apply append infix-operators-lst-for-parser))

(define operators-lst-syntax
  (apply append infix-operators-lst-for-parser-syntax))



) ; end module
