#lang racket
(provide sumofsquares join-strings make-html-tags get-total-salaries)

;; Given a list of numbers, produce the sum of their squares. 
;; Use foldr, not recursion.
(define (sumofsquares lst)
  (foldr (lambda (x y) (+ y (* x x))) 0 lst)
)

;; Using foldl, combine a list of strings into a single string,
;; separated by the specified separator.  Separators should only
;; appear between words
(define (join-strings list-of-strings separator)
  (foldl (lambda (x y) (if (string=? y "")
                           x
                           (string-append y separator x))) "" list-of-strings)
)

;; Make matching open and close tags, using the list of tag-names.
;; Use string-append, make the open tags with foldl, and the closing tags with foldr.
(define (make-html-tags tag-names)
  (string-append (foldl (lambda (x y) (string-append y "<" x ">")) "" tag-names)
                 (foldr (lambda (x y) (string-append y "</" x ">")) "" tag-names))
)

(define employees
  '( ("Robert" "Tables" 100000 "Manager")
     ("Alice" "Liddell" 50000 "Copy editor")
     ("Tweedle" "Dee" 46000 "entry level")
     ("Tweedle" "Dum" 46000 "entry level")
     ("William" "Gates" 100000000000 "Manager")
     ("Marcus" "Aurelius" 0 "Manager")))

;; Given the above list of employees, return the sum of salaries
;; for employees matching the specified predicate.
(define (get-total-salaries pred)
  (foldr (lambda (x y) (+ (caddr x) y)) 0 (filter pred employees))
  )
