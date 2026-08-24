(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

;;@doc
;; Get k8s deployments and apply the output to the currently opened buffer.
;; Can be ran with 0 arguments or with custom argument `namespace` for a
;; specific namespace.
;; Args:
;;  0 - namespace
;;  1 - `t` for true, output will be shown as a shell command
;; Example usage:
;;  `k8s-g-deploy`
;;  `k8s-g-deploy NAMESPACE_NAME`   <- applied on active buffer
;;  `k8s-g-deploy NAMESPACE_NAME t` <- applied on shell output
(define (k8s-g-deploy . args)
  (define namespace (if (> (length args) 0) (list-ref args 0) "A"))
  (define output_as_shell (if (> (length args) 1) (list-ref args 1) #f))

  (define cmd
      (if (string=? namespace "A")
        "kubectl get deployment -A"
        (string-append "kubectl get deployments -n " namespace)
          )
    )

    (if output_as_shell
      (helix.run-shell-command cmd)
      (helix.insert-output cmd)
        )
)

(provide k8s-g-deploy)
