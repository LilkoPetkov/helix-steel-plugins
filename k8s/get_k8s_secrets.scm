(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(require "../global/global_steel_funcs.scm")

(define *last-selection* "")

(define (get-last-selection)
  *last-selection*
  )

;; @doc
;; Get ALL the secrets from the currently highlighted k8s namespace
(define (k8s-g-secrets)
  (define ns (helix.static.current-highlighted-text!))
  (if (not (string=? ns ""))
      (begin
        (set! *last-selection* ns)
        (helix.echo (string-append "Saved namespace: " ns)))
      (helix.echo "Warning: No text highlighted, keeping previous namespace."))

  (define cmd
    (string-append "kubectl get secrets -n " ns)
    )

  (helix.echo cmd)

  (clean-canvas)
  (helix.insert-output cmd)
  )

(provide k8s-g-secrets *last-selection* get-last-selection)
