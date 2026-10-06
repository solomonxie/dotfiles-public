;; Allow overrides:
; extends

;; Functions and classes (methods included) merged into one capture, so
;; `]]`/`[[` can move through all of them instead of just @function.outer.
((decorated_definition)?
  (function_definition
    body: (block)? @definition.inner)) @definition.outer

((decorated_definition)?
  (class_definition
    body: (block)? @definition.inner)) @definition.outer
