(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(require "../global/global_steel_funcs.scm")

(define (k8s-g-prom-rules)
  (define ns (helix.static.current-highlighted-text!))
  (if (not (string=? ns ""))
      (begin
        (set-last-selection! ns)
        (helix.echo (string-append "Saved namespace: " ns)))
      (helix.echo "Warning: No text highlighted, keeping previous namespace."))

  (clean-canvas)
  (helix.insert-output (string-append "kubectl get prometheusrules -n " ns " --show-kind"))
  )

(provide k8s-g-prom-rules *last-selection*)
