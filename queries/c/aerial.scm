;; Capture struct/union fields as children
(field_declaration declarator: (field_identifier) @field)

;; Capture function parameters
(parameter_declaration declarator: (identifier) @parameter)

;; Capture enum constants
(enumerator name: (identifier) @enum-constant)
