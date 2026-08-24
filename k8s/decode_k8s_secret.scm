(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(require "./get_k8s_secrets.scm")
(require "../global/global_steel_funcs.scm")

;; @doc
(define (k8s-decode-secret)
  (define ns (get-last-selection))
  (define current_secret (helix.static.current-highlighted-text!))

  (cond
    [(string=? ns "")
      (helix.echo "Error: No saved namespace in buffer, please run `k8s-g-secrets`")
     ]
    [(string=? current_secret "")
      (helix.echo "Error: No highlighted secret")
     ]
    [else
      (clean-canvas)
      (helix.insert-output
        (string-append "kubectl get secret " current_secret " -n " ns " -o go-template='
                        {{range $k,$v := .data}}{{printf \"%s: \" $k}}{{if not $v}}{{$v}}{{else}}{{$v | base64decode}}{{end}}{{\"\\n\"}}{{end}}'")
        )
      ]
    )
  )


(provide k8s-decode-secret)
