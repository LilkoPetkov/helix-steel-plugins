(require "helix/static.scm")


;;@doc
;; Inserts "Hello, World!" at the cursor position
(define (insert-hello)
    (insert_string "Hello, World!")
  )

(provide insert-hello)
