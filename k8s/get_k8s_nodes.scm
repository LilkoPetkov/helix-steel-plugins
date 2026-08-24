(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

;;@doc
;; Get k8s nodes and apply them to the currently opened buffer.
;; Can be ran with 0 arguments or with custom argument `w` for
;; wide spread.
;; Args:
;;  0 - wide
;;  1 - t for true if we want to get the stdout in shell window
;; Example usage:
;;  `k8s-g-nodes`
;;  `k8s-g-nodes w`      <- applied to active buffer
;;  `k8s-g-nodes w f`    <- shell output
(define (k8s-g-nodes . args)
  (define wide (if (> (length args) 0) (list-ref args 0) ""))
  (define output_as_shell (if (> (length args) 1) (list-ref args 1) #f))

  (define cmd
    (if (string=? wide "w")
        "kubectl get nodes -o wide"
        "kubectl get nodes"
        )
    )

  (if output_as_shell
    (helix.run-shell-command cmd)
    (helix.insert-output cmd)
      )

)

(provide k8s-g-nodes)
