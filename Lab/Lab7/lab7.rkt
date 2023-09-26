#lang racket



(define-syntax switch
  (syntax-rules ()
    [(switch x (val exp)) exp]
    [(switch x [val exp] rest ...)
     (if (eqv? x val)
         exp
         (switch x rest ...))]))



(define x 99)
(switch x
    [3 (displayln "x is 3")]
    [4 (displayln "x is 4")]
    [5 (displayln "x is 5")]
    [default (displayln "none of the above")])



(define y 5)
(switch y
    [3 (+ y 1)]
    [4 (+ y 2)]
    [5 (+ y 3)]
    [default (displayln "none of the above")])
