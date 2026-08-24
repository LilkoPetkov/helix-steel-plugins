(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(require "./get_k8s_workload.scm")
(require "../global/global_steel_funcs.scm")

;;@doc
;; Runs kubectl logs and dumps output directly into the active buffer.
;; Can be run with 0 arguments (uses defaults) or called with custom arguments.
;; Args:
;;  0 - number of lines to get
;;  1 - grep expression
;;  2 - `t` for displaying the output as shell command
;; Example usage: `k8s-g-logs otlp-collector-opentelemetry-collector otlp 150`
(define (k8s-g-logs . args)
    (define deploy (helix.static.current-highlighted-text!))
    (define ns (get-last-selection))
    (define lines           (if (> (length args) 0) (list-ref args 0) 120))
    (define grep_exp        (if (> (length args) 1) (list-ref args 1) #f))
    (define output_as_shell (if (> (length args) 2) (list-ref args 2) #f))

    (define grep-clause
    (if (and grep_exp (not (string=? (to-string grep_exp) "")))
        (string-append " | grep -iE \"" (to-string grep_exp) "\"")
        ""))

    (define cmd
      (string-append "kubectl logs " deploy
                     " -n " ns
                     " --all-pods=true 2>&1"
                     grep-clause
                     " | tail -" (to-string lines)))

    (clean-canvas)
    (helix.set-language "json")
    (if output_as_shell
      (helix.run-shell-command cmd)
      (helix.insert-output cmd)))


(provide k8s-g-logs)
