(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

;;@doc
;; Get all k8s namespaces available in the current active
;; context and apply them to the currently opened buffer.
;; Example usage: `k8s-g-ns`   <- Output in regular buffer as text
;; Example usage: `k8s-g-ns t` <- Shell output
(define (k8s-g-ns . args)
    (define output_as_shell (if (> (length args) 0) (list-ref args 0) #f))

    (if output_as_shell

        (helix.run-shell-command "kubectl get ns")
        (helix.insert-output "kubectl get ns")
        )
  )

(provide k8s-g-ns)
