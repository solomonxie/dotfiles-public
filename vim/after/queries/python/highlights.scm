;; Allow overrides:
; extends

;; Function definitions
(function_definition
  name: (identifier) @function)

;; Function calls (lower priority than base query's builtin-function list,
;; so e.g. __import__()/open() keep @function.builtin's color instead of this)
(call
  function: (identifier) @function.call
  (#set! "priority" 95))

;; Function parameters
(parameters
  (identifier) @variable.parameter)

;; Global variables (top-level assignments)
(module
  (expression_statement
    (assignment
      left: (identifier) @variable.global))
)

;; Imported names
(import_statement
  name: (dotted_name (identifier) @module.imported))

(import_from_statement
  name: (dotted_name (identifier) @module.imported))

;; Bare string statements """...""" used as comments (not docstrings, not assigned)
(expression_statement (string) @comment)

