(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))
(require-builtin helix/core/text)

(require "../k8s/get_k8s_all.scm")
(require "../global/global_steel_funcs.scm")

;;@doc
;; Captures current selection as a string and passes it to
;; k8s-g-all in order to fetch all resources for the Namespace
(define (k8s-g-wk)
  (define selected-str (helix.static.current-highlighted-text!))

  (if (not (string=? selected-str ""))
      (begin
        (set-last-selection! selected-str)
        (helix.echo (string-append "Saved namespace: " selected-str)))
      (helix.echo "Warning: No text highlighted, keeping previous namespace."))

  (clean-canvas)
  (k8s-g-all (get-last-selection)))

(provide k8s-g-wk)
