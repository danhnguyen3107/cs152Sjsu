#lang racket

;; Expressions in the language
(struct b-val (val))
(struct b-if (c thn els))
(struct b-succ (n))
(struct b-pred (n))

;; An expression is represented by one of our structs above.
(define (expression? e)
  (match e
    [(struct b-val (_)) #t]
    [(struct b-if (_ _ _)) #t]
    [(struct b-pred (_)) #t]
    [(struct b-succ (_)) #t]
    [_ #f]))

;; A value will be either a Scheme boolean value or a Scheme number.
(define (value? v)
  (or (number? v)
      (boolean? v)))


;; Main evaluate method
(define/contract (evaluate prog)
  (-> expression? value?)
  (match prog
    [(struct b-val (v)) v]
    [(struct b-if (e1 e2 e3))
     (if (evaluate e1)
         (evaluate e2)
         (evaluate e3))]
    [(struct b-succ (n)) (+ (evaluate n) 1)]
    [(struct b-pred (n)) (- (evaluate n) 1)]
    [_ (error "Unrecognized expression")]))

;; true
(evaluate (b-val #t))

;; false
(evaluate (b-val #f))

;; if true then
;;    (if false then true else false)
;; else false
(evaluate (b-if (b-val #t)
                (b-if (b-val #f) (b-val #t) (b-val #f))
                (b-val #f)))

;; Consider the following sample programs for extending the interpreter
; succ 1  =>  returns 2
(evaluate (b-succ (b-val 1)))

; succ (succ 7) => returns 9
(evaluate (b-succ (b-succ (b-val 7))))

; pred 5 => returns 4
(evaluate (b-pred (b-val 5)))

; succ (if true then 42 else 0) => 43
(evaluate (b-succ (b-if (b-val #t)
                        (b-val 42)
                        (b-val 0))))


















