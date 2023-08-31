#lang racket

;; The big-num data structure is essentially a list of 3 digit numbers.

;; Exporting methods
(provide big-add big-subtract big-multiply big-power-of pretty-print
         number->bignum string->bignum bignum? zero-or-one? one-block?)

(define MAX_BLOCK 1000)

;; Contract verifying the datatype of a bignum
(define (bignum? n)
  (cond [(not (list? n)) #f]
        [(not (list-of-ints? n)) #f]
        [else #t]))

;; Helper contract
(define (list-of-ints? lst)
  (cond [(empty? lst) #t]
        [(integer? (car lst)) (list-of-ints? (cdr lst))]
        [else #f]))

;; Contract to ensure a number is 0 or 1.
(define (zero-or-one? n)
  (match n
    [0 #t]
    [1 #t]
    [_ #f]))

;; Contract to insure a number is an integer in the range of 0-999.
(define (one-block? n)
  (and (integer? n)
       (>= n 0)
       (< n 1000)))

;; Addition of two big-nums
(define/contract (big-add x y)
  (-> bignum? bignum? bignum?)
  (big-add1 x y 0)
  )

(define/contract (big-add1 x y co)
  (-> bignum? bignum? zero-or-one? bignum?)
  (cond
    ;; If both lists are empty, the return value is either 0 or the caryover value.
    [(and (= 0 (length x)) (= 0 (length y)))
      (if (= co 0) '() (list co))]
    [(= 0 (length x))  (big-add1 (list co) y 0)]
    [(= 0 (length y))  (big-add1 x (list co) 0)]
    [else
       ;;
       ;; --- YOUR CODE HERE ---
     
       (define sum (+ (car x) (car y) co))
       (if (>= sum MAX_BLOCK) 
           (cons (- sum  MAX_BLOCK) (big-add1 (cdr x) (cdr y) 1))
           (cons sum (big-add1 (cdr x) (cdr y) 0)))
      
       ;;

     ]
    ))

;; Subtraction of two big-nums
(define/contract (big-subtract x y)
  (-> bignum? bignum? bignum?)
  (let ([lst (big-subtract1 x y 0)])
    (reverse (strip-leading-zeroes (reverse lst)))
  ))

(define/contract (strip-leading-zeroes x)
  (-> bignum? bignum?)
  (cond
    [(= 0 (length x)) '(0)]
    [(= 0 (car x)) (strip-leading-zeroes (cdr x))]
    [else x]
    ))

;; NOTE: there are no negative numbers with this implementation,
;; so 3 - 4 should throw an error.
(define/contract (big-subtract1 x y borrow)
  (-> bignum? bignum? zero-or-one? bignum?)
  ;;
  ;; --- YOUR CODE HERE ---
  (cond
    [(and (= 0 (length x)) (= 0 (length y)))
     (if (= borrow 0) '() (error "Not implemented"))]
    [(< (length x) (length y)) (error "Not implemented")]
    [(= (length y) 0) (big-subtract1 x (list borrow) 0)]
    [else
     (define res (- (car x) (car y) borrow))
     (if (< res 0)
         (cons (+ MAX_BLOCK res) (big-subtract1 (cdr x) (cdr y) 1))
         (cons res (big-subtract1 (cdr x) (cdr y) 0)))
     ]
    )
  ;;(error "Not implemented")
  )

;; Returns true if two big-nums are equal
(define/contract (big-eq x y)
  (-> bignum? bignum? boolean?)
  ;;
  ;; --- YOUR CODE HERE ---
  (cond
    [(and (= 0 (length x)) (= 0 (length y))) #t]
    [(= 0 (length x)) #f]
    [(= 0 (length y)) #f]
    [(= (car x) (car y)) (big-eq (cdr x) (cdr y))]
    [else #f]
    )
  )

;; Decrements a bignum
(define/contract (big-dec x)
  (-> bignum? bignum?)
  (big-subtract x '(1))
  )

(define/contract (helper x y num)
  (-> bignum? integer? integer? bignum?)
  (cond
    [(= (length x) 0)
      (if (= num 0) '() (list num))]
    [else
     
     (define res (+ (* (car x) y) num))
     (cons
      (remainder res MAX_BLOCK)
      (helper (cdr x) y (quotient res MAX_BLOCK)))
     ]
    )
  
  )

;; Multiplies two big-nums
(define/contract (big-multiply x y)
  (-> bignum? bignum? bignum?)
  ;;
  ;; --- YOUR CODE HERE ---
  ;;
  (cond
    [(and (= 1 (length x)) (= 0 (car x))) '(0)]
    [(and (= 1 (length y)) (= 0 (car y))) '(0)]
    [(= 0 (length y)) '()]
    [else (big-add (helper x (car y) 0) (cons 0 (big-multiply x (cdr y))))])

  
  ;; Follow the same approach that you learned in
  ;; grade school for multiplying numbers, except
  ;; that a "block" is 0-999, instead of 0-9.
  ;; Consider creating a helper function that multiplies
  ;; a big-number with a integer in the range of 0-999.
  ;; Once you have that working, you can use it in your
  ;; solution here.
  )

;; Raise x to the power of y
(define/contract (big-power-of x y)
  (-> bignum? bignum? bignum?)
  ;;
  ;; --- YOUR CODE HERE ---
  ;;
  (cond
    [(and (= (length y) 1) (= (car y) 0)) '(1)]
    [else (big-multiply x (big-power-of x (big-dec y)))])
  )

;; Dispaly a big-num in an easy to read format
(define (pretty-print x)
  (let ([lst (reverse x)])
    (string-append
     (number->string (car lst))
     (pretty-print1 (cdr lst))
     )))

(define (pretty-print1 x)
  (cond
    [(= 0 (length x))  ""]
    [else
     (string-append (pretty-print-block (car x)) (pretty-print1 (cdr x)))]
    ))

(define (pretty-print-block x)
  (string-append
   ","
   (cond
     [(< x 10) "00"]
     [(< x 100) "0"]
     [else ""])
   (number->string x)))

;; Convert a number to a bignum
(define/contract (number->bignum n)
  (-> number? bignum?)
  (cond
    [(< n MAX_BLOCK) (list n)]
    [else
     (let ([block (modulo n MAX_BLOCK)]
           [rest (floor (/ n MAX_BLOCK))])
       (cons block (number->bignum rest)))]))

;; Convert a string to a bignum
(define/contract (string->bignum s)
  (-> string? bignum?)
  (let ([n (string->number s)])
    (number->bignum n)))
