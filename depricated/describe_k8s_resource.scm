(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

;;@doc
;; Describe k8s services and apply the output to the currently opened
;; buffer. Can be ran with 0 arguments or with custom arguments.
;; Args:
;;  0 - resource type (pod, namespace, etc)
;;  1 - resource name (pod name, namespace name, etc)
;;  2 - namespace
;; Example usage:
;;  `d-resource deployment vm-dis-grafana victoria-metrics`
;;  `d-resource node NODE_NAME`
(define (k8s-d-resource . args)
  (define resource_type (if (> (length args) 0) (list-ref args 0) "pod"))
  (define resource_name (if (> (length args) 1) (list-ref args 1) ""))
  (define namespace (if (> (length args) 2) (list-ref args 2) ""))

  (if (string=? resource_type "node")
    (helix.insert-output (string-append "kubectl describe " resource_type " " resource_name))

    (if (string=? namespace "A")
      (helix.insert-output (string-append "kubectl describe " resource_type " -A"))
      (helix.insert-output (string-append "kubectl describe " resource_type " " resource_name " -n" namespace))
        )
      )

)

(provide k8s-d-resource)
