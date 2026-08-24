(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

;;@doc
;; Get k8s all and apply the output to the currently opened buffer.
;; Args:
;;  0 - namespace to fetch workload for
;;  1 - `t` for true, output will be shown as a shell command
;; Example usage:
;;  `k8s-g-all NAMESPACE_NAME`      <- applied on active buffer
;;  `k8s-g-events NAMESPACE_NAME t` <- applied on shell output
(define (k8s-g-all . args)
    (define namespace (if (> (length args) 0) (list-ref args 0) "default"))
    (define output_as_shell (if (> (length args) 1) (list-ref args 1) #f))

    (define cmd
        (string-append "kubectl get all -n " namespace)
        )

    (if output_as_shell
        (helix.run-shell-command cmd)
        (helix.insert-output cmd)

        )
)

(provide k8s-g-all)


