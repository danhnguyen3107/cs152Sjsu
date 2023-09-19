#lang racket
(provide max-num fizzbuzz)

(define (max-num lst)
    (cond [(null? (list-tail lst 1)) (list-ref lst 0)]
        [else (max (list-ref lst 0) (max-num (list-tail lst 1)))])
  )


;; The function counts from 1 to the specified number, printing a string with the result.
;; The rules are:
;;    If a number is divisible by 3 and by 5, instead say "fizzbuzz"
;;    Else if a number is divisible by 3, instead say "fizz"
;;    Else if a number is divisible by 5, instead say "buzz"
;;    Otherwise say the number
;;
(define (fizzbuzz n)
   (cond [(= n 0) ""]
        [(and (integer? (/ n 3)) (integer? (/ n 5))) (string-append (fizzbuzz (- n 1)) "fizzbuzz ")]
        [(integer? (/ n 3)) (string-append (fizzbuzz (- n 1)) "fizz ")]
        [(integer? (/ n 5)) (string-append (fizzbuzz (- n 1)) "buzz ")]
        [else (string-append (fizzbuzz (- n 1)) (number->string n) " ")])
  )

