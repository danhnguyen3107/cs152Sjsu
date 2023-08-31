#lang racket

(provide reverse add-two-lists positive-nums-only)

(define (reverse lst)
  (cond
    [(= (length lst) 0) '()]
    [else (append (reverse (cdr lst)) (list (car lst)))])
  )

(define (add-two-lists lst1 lst2)
  (cond
    [(and (= (length lst1) 0) (= (length lst2) 0))'()]
    [(= (length lst1) 0)
     (cons (car lst2)(add-two-lists lst1 (cdr lst2)))]
    [(= (length lst2) 0)
     (cons (car lst1)(add-two-lists (cdr lst1) lst2))]
    [else
     (cons (+ (car lst1) (car lst2)) (add-two-lists (cdr lst1) (cdr lst2)))])
  )

(define (positive-nums-only lst)
   (cond
     [(= (length lst) 0) '()]
     [(<= (car lst) 0) (positive-nums-only (cdr lst))]
     [else (cons (car lst) (positive-nums-only (cdr lst)))])
  )
