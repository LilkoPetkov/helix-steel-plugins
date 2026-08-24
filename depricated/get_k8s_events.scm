(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

;;@doc
;; Get k8s events and apply the output to the currently opened buffer.
;; Can be run with 0 arguments (uses default as all namespaces) or
;; called with custom argument as target namespace.
;; Args:
;;  0 - namespace to fetch events for
;;  1 - `t` for true, output will be shown as a shell command
;; Example usage:
;;  `k8s-g-events` = `k8s-g-events A`
;;  `k8s-g-events NAMESPACE_NAME`   <- applied on active buffer
;;  `k8s-g-events NAMESPACE_NAME t` <- applied on shell output
(define (k8s-g-events . args)
    (define namespace (if (> (length args) 0) (list-ref args 0) "A"))
    (define output_as_shell (if (> (length args) 1) (list-ref args 1) #f))

    (define cmd
      (if (string=? namespace "A")
          "kubectl get events -A"
          (string-append "kubectl get events -n " namespace)
          )
      )

    (if output_as_shell
      (helix.run-shell-command cmd)
      (helix.insert-output cmd)
        )
)

(provide k8s-g-events)


