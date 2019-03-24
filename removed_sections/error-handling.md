# Errors
... Why talk about errors? ...

> The problem of how to signal to the caller of your function that something went wrong.
>
> [@go-gets-exceptions-right]

- http://blogs.perl.org/users/ovid/2010/08/what-to-know-before-debating-type-systems.html (when talking about Haskell's `lookup` fn)
- http://joeduffyblog.com/2016/02/07/the-error-model/
- https://blog.golang.org/errors-are-values

# Connection between error models and type systems
...

# Run time vs. Compile time errors
- a futtatást megelőzően bizonyosodunk meg a helyességről: statikus ellenőrzés
...

## Early ways of error handling
... we'll briefly look at the error models of early languages and highlight their weaknesses ...

### Sentinel values, return codes
- https://en.wikipedia.org/wiki/Sentinel_value

- drawbacks of old / C-style error handling
    - https://dave.cheney.net/2012/01/18/why-go-gets-exceptions-right (first few paragraphs)

In the case of "sentinel values", some values in the range of the function (as defined by its return type)
are interpreted as having a special meaning. This has the advantage of being very simple to implement (from the
language's point of view). It is also very easy to forget to handle these values - the errors can go unnoticed.

> Values that are considered impossible as a calculation result are repurposed as error indicators.
> [...] Due to a lack of type safety or by faulty or no type checking,
> we can accidentally use return values indicating errors as if they were computation results.
>
> [@heumen-error-handling]

For example, the `fork()` function in the C standard library returns `-1` in case of an error.
That return value can be used with the `kill()` function to kill a process which also takes an integer, 
the ID of which it tries to `kill()`.
If we failed to error-check the return value of fork, we might accidentally give that `-1` to kill.
`kill(-1)` means "kill every process except for PID1". Unfortunate.

We can interpret the return value of a function as a signal (an "error code" in case of a failure), but if the function wants to
give back anything else to the caller, then other function parameters must be defined, which it can mutate
or have it mutate a global (non-local) variable somewhere in the outer scope but that leads to other problems.

One might use the return value for the result of the computation and
explicitly pass an error "object" to the function which can be filled with the details of the error, if any.
[@heumen-why-i-prefer]

### Note about returned error values
We'll later see more variations on "errors as return values".
Regardless of the nature of the value, we can state the following about returned errors:
- they move only one level: from the called function to the caller function
- not propagated further, unless explicitly done so by the programmer
- every information about the error is available at the call site
- error handling is localized to one specific function call
[@heumen-why-i-prefer]

An "exception mechanism" is fundamentally different, which we'll discuss below.

### Exceptions
> Exceptions provide safe and flexible error handling in applications: if an exception is not explicitly handled
> in a function by the programmer, it is automatically propagated upwards in the call graph until a funtion that "knows" how
> to deal with the exception is found.
>
> [@leroy-type-based-analysis]

Characteristics of exceptions:
- the mechanism is provided by the runtime **?TRUE?**
- exceptions are special events that take a different route than normal code
- they automatically propagate through multiple levels up the call stack
- exact information about the error is likely not available where it is handled
- error handling can be - carelessly - done in "batch": the same `try/catch` for multiple lines of code
[@heumen-why-i-prefer]

> Throwing an exception is usually ridiculously expensive. This is almost always due to the gathering of a stack trace [...]
> If the error is caught and handled, however, you don’t even need that information at runtime.
>
> [@duffy-error-model]

**duffy-error-model talks a lot about exceptions!**
...

> This might be surprising to some people, since undoubtedly everyone has heard that “exceptions are slow.”
> It turns out that they don’t have to be. And, when done right, they get error handling code and data off hot paths
> which increases I-cache and TLB performance [...]
>
> [@duffy-error-model]

**TODO**
papers: (references found in Duffy: Error model)
    - "Exception handling in CLU" by Barbara Liskov - http://csg.csail.mit.edu/pubs/memos/Memo-155/Memo-155-3.pdf
    - "Exception handling: issues and a proposed notation" by John B. Goodenough - http://web.eecs.umich.edu/~weimerw/2006-615/reading/goodenough-exceptions.pdf

#### Unchecked exceptions
...

> In an unchecked exceptions model, you throw and catch exceptions, without it being part of the type system or a function’s signature [...]
> In this model, any function call – and sometimes any statement – can throw an exception, transferring control non-locally
> somewhere else. Where? Who knows. There are no annotations or type system artifacts to guide your analysis.
>
> [@duffy-error-model]

#### Checked exceptions
In a checked exceptiosn model (java), functions that may throw exceptions must be explicitly annotated.
The caller has 3 options:
- throw the exceptions to its caller
- stop the flow of exceptions by handling them
- transform the exception types (throw a "parent" type)
[@duffy-error-model]

### Multiple return values
> Multiple return values ensure that we do not reduce expressivity of computation result in order to squeeze in error handling.
> The static type system and the dedicated error type ensure that we do not interpret an error as a value.
>
> [@heumen-error-handling]

### Monadic error handling / Option types

> Functional languages address many of the usability challenges by packaging up the possibility of either a value or an error,
> into a single data structure. Because you’re forced to pick apart the error from the value if you want to do anything
> useful with the value at the callsite – which, thanks to a dataflow style of programming, you probably will – it’s easy to avoid
> the killer problem of forgetting to check for errors.
>
> [@duffy-error-model]

- https://en.wikipedia.org/wiki/Option_type
    - are they the same?

# A type system's role in error handling
...
