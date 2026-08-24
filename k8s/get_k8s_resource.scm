(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(require "./get_k8s_workload.scm")
(require "../global/global_steel_funcs.scm")

;;@doc
;; Get a resource using the stored namespace saved from k8s-g-wk.
;; Args:
;;   - A member of the following list of values (json, yaml, kyaml, name, go-template, go-template-file,
;;     template, templatefile, jsonpath, jsonpath-as-json, jsonpath-file,
;;     custom-columns, custom-columns-file, wide)
(define (k8s-get . args)
  (define output_format (if (> (length args) 0) (list-ref args 0) "yaml"))
  (define resource (helix.static.current-highlighted-text!))
  (define ns (get-last-selection))

  (define valid_output_formats '("json" "yaml" "kyaml" "name" "go-template" "go-template-file" "template" "templatefile" "jsonpath" "jsonpath-as-json" "jsonpath-file" "custom-columns" "custom-columns-file" "wide"))

  (cond
    [(not (member output_format valid_output_formats))
      (helix.echo "Error: output format is invalid, please read the description to see all available fromats")
     ]
    [(string=? resource "")
      (helix.echo "Error: No resource selected in buffer")]
    [(string=? ns "")
      (helix.echo "Error: No namespace saved. Run k8s-g-wk first.")]
    [else
      (clean-canvas)
      (helix.insert-output
       (string-append "kubectl get " resource " -n " ns " -o " output_format))]))

(provide k8s-get)

