(require "helix/static.scm")
(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(define (current-path)
  (let* ([focus (editor-focus)]
         [focus-doc-id (editor->doc-id focus)])
    (editor-document->path focus-doc-id)))

;;@doc
;; Specialized shell implementation, where % is a wildcard for the current file
(define (shell . args)
  (helix.insert-output
    (string-join
      ;; Replace the % with the current file
      (map (lambda (x) (if (equal? x "%") (current-path) x)) args)
      " ")))

;;@doc
;; `get-command-stdout`
;; Run a command and apply its stdout to the currently active
;; buffer.
;; Example usage:
;;  `general-gcs ls -lah`
(define (general-gcs . args)
  
  (if (= (length args) 0)
    (helix.echo "please pass a command")
    (shell (to-string args))
      )
)

(provide general-gcs)

