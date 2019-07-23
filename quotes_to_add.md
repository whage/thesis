# pfpl
The first part, called preservation, says that the steps of evaluation preserve typing; the second,
called progress, ensures that well-typed expressions are either values or can be further evaluated.
Safety is the conjunction of preservation and progress.

# Static vs dynamic checking (http://www.cs.tau.ac.il/~msagiv/courses/pl15/types.pdf)
Basic tradeoff
– Both kinds of checking prevent type errors
– Run-time checking slows down execution
– Compile-time checking restricts program flexibility
• JavaScript array: elements can have different types
• OCaml list: all elements must have same type 

# pfpl
Thus what is called the void type in many languages is really the type unit because it
indicates that an expression has no interesting value, not that it has no value at all!
