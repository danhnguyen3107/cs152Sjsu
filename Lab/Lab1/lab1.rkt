#lang racket

(define y (list -1 -6 -5 -4))
(define x 0)
(define [max-num lst]
  (cond [(null? (list-tail lst 1)) (list-ref lst 0)]
        [else (max (list-ref lst 0) (max-num (list-tail lst 1)))])
        
  )
(max-num y)


(define [fizzbuzz n]
  (cond [(= n 0) ""]
        [(and (integer? (/ n 3)) (integer? (/ n 5))) (string-append (fizzbuzz (- n 1)) "fizzbuzz ")]
        [(integer? (/ n 3)) (string-append (fizzbuzz (- n 1)) "fizz ")]
        [(integer? (/ n 5)) (string-append (fizzbuzz (- n 1)) "buzz ")]
        [else (string-append (fizzbuzz (- n 1)) (number->string n) " ")])
  )

(define greeting "")
