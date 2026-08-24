(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

;;@doc
;; Get k8s services and apply them to the currently opened buffer.
;; Can be run with 0 arguments (uses default as false for shell
;; window output and all namespaces) or called with custom argument
;; as target namespace.
;; Args:
;;  0 - namespace to fetch services for
;;  1 - t for true if we want to get the stdout in shell window
;; Example usage:
;;  `k8s-g-svc` = `k8s-g-svc A`
;;  `k8s-g-svc NAMESPACE_NAME`   <- applied to active buffer
;;  `k8s-g-svc NAMESPACE_NAME f` <- shell output
(define (k8s-g-svc . args)
    (define namespace (if (> (length args) 0) (list-ref args 0) "A"))
    (define output_as_shell (if (> (length args) 1) (list-ref args 1) #f))

    (define cmd
      (if (string=? namespace "A")
          "kubectl get svc -A"
          (string-append "kubectl get svc -n " namespace)))

    (if output_as_shell
        (helix.run-shell-command cmd)
        (helix.insert-output cmd)
    )

  )


(provide k8s-g-svc)
