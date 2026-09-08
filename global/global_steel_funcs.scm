(require (prefix-in helix.static. "helix/static.scm"))

;; @doc
;; Select everything and clean it from the canvas
(define (clean-canvas)
    (helix.static.select_all)
    (helix.static.delete_selection)
  )

(define *last-selection* "")

(define (get-last-selection)
  *last-selection*
  )

(define (set-last-selection! val)
    (set! *last-selection* val)
    )

(provide *last-selection* clean-canvas get-last-selection set-last-selection!)
