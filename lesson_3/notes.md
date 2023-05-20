# Lesson 3 notes

Methods to compare objects and values:

- `#==`
- `equal?`
- `#===`
- `#eql?`

- Uninitialised instance variables return `nil`
- Lexical scope does not include the main scope, the top level scope (main scope) is only searched after ruby tries the inheritance hierarchy. First the lexical scope of the reference, then the inheritance chain of the enclosing structure, and then the top level.
