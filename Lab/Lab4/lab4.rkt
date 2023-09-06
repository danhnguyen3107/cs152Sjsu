#lang racket
(provide sumofsquares join-strings make-html-tags get-total-salaries)

;; Given a list of numbers, produce the sum of their squares. 
;; Use foldr, not recursion.
(define (sumofsquares lst)
  0 ;; YOUR CODE HERE
)

;; Using foldl, combine a list of strings into a single string,
;; separated by the specified separator.  Separators should only
;; appear between words
(define (join-strings list-of-strings separator)
  "";; YOUR CODE HERE
)

;; Make matching open and close tags, using the list of tag-names.
;; Use string-append, make the open tags with foldl, and the closing tags with foldr.
(define (make-html-tags tag-names)
  "" ;; YOUR CODE HERE
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
  0 ;; YOUR CODE HERE
  )