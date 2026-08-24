(require (prefix-in helix.static. "helix/static.scm"))

;; @doc
;; Select everything and clean it from the canvas
(define (clean-canvas)
    (helix.static.select_all)
    (helix.static.delete_selection)
  )

(provide clean-canvas)
