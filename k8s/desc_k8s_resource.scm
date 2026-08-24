(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(require "./get_k8s_workload.scm")
(require "../global/global_steel_funcs.scm")

;;@doc
;; Describes a resource using the stored namespace saved from k8s-g-wk.
(define (k8s-describe)
  (define resource (helix.static.current-highlighted-text!))
  (define ns (get-last-selection))

  (cond
    [(string=? resource "")
      (helix.echo "Error: No resource selected in buffer!")]
    [(string=? ns "")
      (helix.echo "Error: No namespace saved! Run k8s-g-wk first.")]
    [else
      (clean-canvas)
      (helix.insert-output
       (string-append "kubectl describe " resource " -n " ns))]))

(provide k8s-describe)
