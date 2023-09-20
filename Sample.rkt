#lang racket

(define ht (hash 'a 3 'b 15))
(define ht2 (hash-set ht 'a 42))

(hash-ref ht2 'c 0)
ht2