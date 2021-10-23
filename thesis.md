\pagenumbering{gobble}
\pagebreak

\tableofcontents

\pagebreak
\pagenumbering{arabic} 

# Introduction, personal motivation {-}
I started programming with dynamically typed languages. I enjoyed the quick results and rapid feedback during development.
My first real exposure to statically typed languages was at the university with C# and Java.
At first, those languages felt cumbersome. The code seemed too verbose, programs didn't work until everything was right,
even a small change triggered a whole chain of errors and the whole thing had to be fixed before I could run my code again.
But it didn't take long until I started seeing their benefits. After spending some time with statically typed languages,
each time I went back to the dynamic ones it felt like a step backwards. Continuous trial and error, edit-run-debug cycles,
uncertainty about the correctness of my code.
Static languages helped me write code more effectively and more confidently.
The typechecker made me to think more thoroughly, it gave me confidence when changing parts of the program.
At this point of my journey in the world of programming, I feel like statically typed languages are superior.
I became more and more interested in the possibilities of static checking and type systems.
I wondered what features can programming languages provide to increase programmer productivity
and improve software quality. This curiosity led me to choosing type systems as the topic of this work.
My goal with this thesis is to gain a more fundamental understanding of the semantics of programming languages -
both static and dynamic.
First, I'll survey the history and theoretical background of type systems.
I'll look at how type systems concepts shaped programming languages.
I'll demonstrate, through example programs the benefits of certain type systems features.
I'll compare the type systems of widely used programming languages and will try to
give an overview of the possibilities of recent advances in type systems and programming language design.

\pagebreak

# Type systems
> Modern software engineering recognizes a broad range of formal methods for helping ensure that a system behaves correctly [...]
> by far the most popular and best established lightweight formal methods are type systems.
> [@tapl, p. 1]

What is a "formal method"?

> Formal methods are a particular kind of mathematically rigorous techniques for the specification, development and verification
> of software and hardware systems. The use of formal methods for software and hardware design is motivated by the expectation that,
> as in other engineering disciplines, performing appropriate mathematical analysis can contribute to the reliability
> and robustness of a design.
> [@formal-methods-wiki]

In contrast, an empirical method - that is based on experimental results - for verifying software systems would be testing.

So one of many formal methods, a type system is a set of rules that associate a property called a type to various constructs
in a computer program. A type defines a range of values as well as possible operations on instances of that type.
In a hardware or compiler context, a type defines the size and memory layout of values of that type.
Here I will focus on types from the perspective of type checking.

> A type is simply a property with which a program is implicitly or explicitly annotated before runtime.
> Type declarations are invariants that hold for all executions of a program, and can be expressed
> as statements such as “this variable always holds a String object,” or “this function
> always returns a tree expression.” [@ppl-2016, p. 100]

The main purpose of type systems is to reduce possibilities for bugs in computer programs.
The type system associates a type with each value in the program and then by examining the flow of these values
attempts to prove that no operation violates its rules.

Such a violation is called a type error. It is an inconsistency in a program according to the type system's rules.
Exactly what constitutes a type error is defined by the type system of the language.
A program that violates the rules of its type system is often called "ill typed". A program that conforms
to those rules is a "well typed" program. [@wiki-type-systems]

> Type systems are used to define the notion of well typing, which is itself a static approximation of good behavior [...]
> Well typing further facilitates program development by trapping execution errors before run time. [@cardelli-96, p. 6]

There are languages that don't associate a type with values, these are called untyped languages.
Most assembly languages fall into this category. In these languages, invalid operations might be applied
to values which could result in a fixed value, a fault, an exception or an unspecified effect.

Typed languages can enforce good behavior by performing static (without executing the program) checks to prevent ill typed
programs from ever running. Untyped languages can enforce good behavior by performing sufficiently detailed
runtime checks to rule out errors. For example, they may check array bounds or division operations and generate
recoverable exceptions. This checking process during runtime is called dynamic checking.
[@cardelli-96]

By using the facilities provided by the type system, we can add more information in our programs.
We can create a safety-net against execution errors by making it possible for automated tools to verify the steps
we take throughout our code.
Through types, we can add more meaning, a deeper, more solid structure. That structure aids
us when we later change parts of the program or add new components to it.

The way I see it, type systems are the glue between mathematical logic and computer programs. They make it possible to
prove that our programs behave correctly. Advanced, sophisticated type systems allow us to express
a finer, more precise structure and thus more properties of our sofware may be proven by automated tools
and more optimization may be carried out to improve performance.

## Type theory
Type theory is a branch of mathematical symbolic logic: a system of representing logical expressions
through the use of symbols. It was concieved in the beginning of the 20th century by Bertrand Russell
in order to resolve contradictions present in set theory. Type theories (there are many,
like Alonzo Church's Simply Typed Lambda calculus or Per Martin-Löf's Intuitionistic Type Theory)
are formal systems which means they define rules for inferring theorems (statements) from axioms.
[@stanford-tt]

> Type theory is a formal language, essentially a set of rules for rewriting certain strings of
> symbols, that describes the introduction of types and their terms, and computations with these, in a sensible way.
> [@ncatlab-tt]

Type theory lays down the theoretical foundation for the type systems found in programming languages and
the typechecking algorithms behind them.

## Formalization of type systems
> How can we guarantee that well typed programs are really well behaved? [...]
> Formal type systems are the mathematical characterizations of the informal type systems
> that are described in programming language manuals. Once a type system is formalized, we can
> attempt to prove a type soundness theorem stating that well typed programs are well behaved.
> If such a soundness theorem holds, we say that the type system is sound.
> [@cardelli-96, p. 7]

Most materials on the formalization of type systems are dense and get very abstract quickly.
Here, I'd like to briefly introduce the basic concepts and standard notation used when
discussing formal type systems.

### Judgements and rules
An expression is a syntactically correct fragment of a program that can be evaluated to a value.
Type systems associate expressions with types. We call this the _has type_ relationship:
$e : M$, where expression $e$ has type $M$. This is called a typing judgement or just judgement. [@tspl-2000]

Judgements are used to build inference rules of the form

\begin{equation*}
    \frac{J_{1} \ldots J_{n}}{J}
\end{equation*}

Where the judgements ${J_{1} \ldots J_{n}}$ above the line are called the premisses and $J$ is the conclusion.
We read the above expression as "from the premisses ${J_{1} \ldots J_{n}}$ we can conclude $J$".
If there are no premisses (meaning if $n$ is 0), then the rule is an axiom.
An inference rule can be read as stating that the premises are sufficient for the conclusion:
to show $J$, it is enough to show ${J_{1} \ldots J_{n}}$.
The collection of such typing rules form the type system of a programming language.

> Type rules assert the validity of certain judgments on the basis of other judgments that are already
> known to be valid. The process gets off the ground by some intrinsically valid judgment [@cardelli-96, p. 10]

In a program, the type of a variable can only be decided by looking at its context (or typing environment) which is a
finite sequence of bindings of program variables to types and is defined by the declarations of the variables.
We can think of context as a lookup table of (variable, type) pairs:

\begin{equation*}
    x_{1}:A_{1}, \ldots \ x_{n}:A_{n}
\end{equation*}

> The role of a type system is to impose constraints on the formations of phrases that are sensitive to
> the context in which they occur.
> [@pfpl-2016, p. 36]

In the standard notaton, context is denoted by the greek letter Gamma:

\begin{equation*}
    \Gamma \vdash e : T
\end{equation*}

Which we read as "expression $e$ has type $T$ in context $\Gamma$".

### Derivations
> A derivation of a judgment is a finite composition of rules, starting with axioms and ending with
> that judgment. It can be thought of as a tree in which each node is a rule whose children are
> derivations of its premises. We sometimes say that a derivation of $J$ is evidence for the validity of
> an inductively defined judgment $J$.
> [@pfpl-2016, p. 15]

If we can construct a derivation for a judgement then we can say that the judgement is valid.

Once the inference rules are constructed, a type checking algorithm can take a program and
through constructing derivations decide if the program is well typed or not. If a program fragment
violates the rules of the type system then we say it has a typing error. Most languages report
a "Type Error" in such cases.

> A term $M$ is well typed for an environment $\Gamma$, if there is a type $A$ such
> that $\Gamma \vdash M : A$ is a valid judgment; that is, if the term $M$ can be given some type. [@cardelli-96, p. 11]
> The discovery of a derivation (and hence of a type) for a term is called the type inference problem.

Our aim when constructing a derivation is to infer the type(s) of an expression. The typing rules in the judgements
that make up the derivation serve as markers for assigning types to the expression at the root of the derivation.
[@pfpl-2016], [@cardelli-96], [@ranta2012]

## A short history of type systems
The origins of type systems and type theory go back to the early 1900s. Type systems were first formalized as a means to avoid
Russell's paradox [@wiki-russells]. It was a mathematical framework at first, "a field of study in logic, mathematics, and philosophy"
as Pierce [@tapl] puts it, with no connection to programming or computers.

> During the twentieth century, types have become standard tools in logic, especially in proof theory [...]
> and have permeated the language of philosophy and science.
> [@tapl, p. 1]

The first type systems in programming language context appeared in the 1950s, when the designers of the Fortran (Backus) and Algol-60 (Naur et al.)
languages wanted to make numerical computations more efficient by distinguishing between integer-valued arithmetic expressions
and real-valued ones. This allowed the compiler to generate the appropriate machine instruction making the
program more efficient.
[@tapl], [@tt-oop]

In the 1960s, the Curry-Howard correspondence was discovered by Haskell Curry and William Alvin Howard.
It is the direct relationship between computer programs and mathematical proofs, the link between logic and computation.
[@wiki-curry-howard]

The Pascal programming language with "strong typing" was developed in the 1970s (Wirth), so was Martin Löf's Type Thery
born and the ML family of languages created.

> In the late 1950s and early 1960s, this classification was extended to structured data (arrays of records, etc.)
> and higher-order functions. In the 1970s, a number of even richer concepts (parametric polymorphism,
> abstract data types, module systems, and subtyping) were introduced, and type systems emerged as a field in its own right.
> At the same time, computer scientists began to be aware of the connections between the type systems
> found in programming languages and those studied in mathematical logic, leading to a rich interplay
> that continues to the present.
> [@tapl, p. 10]

The 1980s brought existential types, dependent types and effect systems. Object calculus (an attempt at clarifying 
the fundamental features of object oriented languages) and typed intermediate languages (a way of preserving type information
through compilation, possibly even in the final target language) have been pioneered in the 1990s by Cardelli [@cardelli-object-calculus]
and Monnier [@monnier-et-al] respectively. Most of these topic, unfortunately, remain hidden within academic papers and research projects.

# Language/type safety
> A safe language is one that protects its own abstractions [...]
> Every high-level language provides abstractions of machine services. Safety refers to the language’s
> ability to guarantee the integrity of these abstractions and of higher-level abstractions
> introduced by the programmer using the definitional facilities of the language.
> [@tapl, p. 6]

As [@tapl] puts it, the abstraction of a safe language can be used "abstractly", whereas in an unsafe language
it is necessary to keep in mind the low level details, like how data is structured in memory or how allocations take place
in order to understand how the program might misbehave.

Note that "language safety" can be achieved by static type checking but also by run-time checks, like
array-bounds checking which is performed by many languages during runtime.

Chappell [@types-primer] says that a programming language or language construct is type-safe if it forbids
operations that are incorrect for the types on which they operate. The author notes that some languages
may discourage incorrect operations or make them difficult without completely forbidding them.

Cardelli [@cardelli-96] differentiates between trapped errors, that cause execution to stop immadiately and
untrapped errors that go unnoticed and later cause arbitrary behaviour. An untrapped error, for example, is
accessing data past the end of an array in absence of run time bounds checks. A trapped error would be division
by zero or accessing an illegal address. He calls a language safe if untrapped errors are impossible in it.
The author suggests declaring a subset of possible execution errors as forbidden errors
(all of the untrapped and some of the trapped erros) and says that a program can be called
"well behaved" if no such forbidden errors can happen during execution.

> Most programming languages exhibit a phase distinction between the static and dynamic phases of
> processing. The static phase consists of parsing and type checking to ensure that the program is
> well-formed; the dynamic phase consists of execution of well-formed programs. A language is
> said to be safe exactly when well-formed programs are well-behaved when executed.
> [@pfpl-2016, p. 35]

To summarize the thoughts of the authors above: a language can be called safe if every program written in it
that can reach execution is well behaved. A well behaved program is one that does not produce forbidden / untrapped errors.
In a theoretical context, "type soundness" is usually used instead of safety but the two are more or less synonyms.

In a more practical sense, soundness is the ability for a type checker to catch every single error that might happen at runtime.
This sometimes means catching errors that will not actually happen at run time.
As a sidenote "completeness" in type systems means the "inverse" of soundness: it is the ability for a
type checker to only ever catch errors that would happen at runtime.
This comes at the cost of sometimes missing errors that will happen at runtime. [@flowjs]

> In modern languages, type systems are sound (they prevent what they claim to) but not complete
> (they reject programs they need not reject). Soundness is important because it lets language users
> and language implementers rely on X never happening [...]
> Type systems are not complete because for almost anything you might like to check statically, it is impossible
> to implement a static checker that given any program in your language (a) always terminates, (b) is sound,
> and (c) is complete. [@cse-341, p.15]

Regardless of whether type checking happens statically (before running the program) or dynamically (while the program is running),
a language may or may not be called safe.
For example, there might be operations that would pass type checking but produce an error during runtime, like division by zero.
Enhancing a type system so that it could protect against division by zero erros would make it too restrictive
(too many programs would be ruled out as ill-formed).
It is not possible to predict statically that an expression would evaluate to zero,
so if we want our language to be safe, we need to add dynamic (runtime) checks. Even though it is not part
of the static type system, such a language is still considered safe. [@pfpl-2016]

## Formal soundness: preservation and progress
Formally, a language can be called "sound" or "type safe" if the following properties hold [@pfpl-2016]:

\begin{enumerate}
  \item If $e : \tau$ and $e \rightarrow e'$, then $e' : \tau$
  \item If $e : \tau$, then either $e$ is a value or there exists $e'$ such that $e \rightarrow e'$
\end{enumerate}

The first property is called "preservation": it states that evaluation preserves the type of an expression.
The second property is called "progress", it states that a well typed expression (one that passes the type checker)
is either a value or it can be further evaluated.

> Progress says that if a term passes the type-checker, it will
> be able to make a step of evaluation (unless it is already a value); preservation says that
> the result of this step will have the same type as the original. If we interleave these
> steps (first progress, then preservation; repeat), we can conclude that the final answer
> will indeed have the same type as the original, so the type system is indeed sound.
> [@krishnamurthi-plai, p. 146.]

Together they state that if we take an expression (or a piece of program) which has type $t$ and evaluate it
then the resulting value will also have type $t$. [@krishnamurthi-plai]

Bonnaire-Sergeant [@uiut] summarizes "preservation" beautifully:

> The essential property of type soundness is “type preservation”, which says that a
> type system’s approximation of the result of a computation (a type) is “preserved” at every
> intermediate computational stage. In other words, the type system’s job is to model a computation,
> and this model should not lose accuracy as the program evaluates.

## Should languages be safe?
Safety reduces debugging time by adding fail-stop behavior in case of execution erros.
Many security problems exist because of buffer overflows made possible by unsafe
casting and pointer arithmetic operations. Languages that provide safety through bounds checking provide protection
against such sources of exploits. Safety guarantees the integrity of run time structures,
and therefore enables garbage collection. [@cardelli-96] Yet there are still unsafe languages
in widspread use, mainly for one reason: performance.

> Some languages, like C, are deliberately unsafe because of performance considerations: the run
> time checks needed to achieve safety are sometimes considered too expensive.
> [...] Thus, the choice between a safe and unsafe language may be ultimately related to a trade-
> off between development and maintenance time, and execution time.
> [@cardelli-96, p. 5.]

# Type checking
Type checking is the process of deciding whether a term is well typed or not.
A type checker verifies that the constraints posed by the type system are not violated
by the program. Type checking can be done by automated tools called typecheckers, which are usually
built into compilers or linkers. [@debating-type-systems]

There are two main branches of languages with regards to type checking (or "typing"): static and dynamic.
Statically typed languages, where variables have a "static" or "unchangeable" type, carry out type checking before the program is actually run.
Dynamically typed languages do type checking during run-time, since variables may change their types during program execution.
Both sides have their advantages and disadvantages.

> The debate regarding the advantages and drawbacks of static or dynamic type systems is
> ongoing in both academia and the software industry. While statically typed programming
> languages such as C, C++, and Java dominated the software market for many years, dynamically
> typed programming languages such as Ruby or JavaScript are increasingly gaining
> ground—especially in web development.
> The fact that the debate is still lively is not surprising, because settling it demands the
> presence of a theory of the respective advantages and disadvantages of static and dynamic
> typing, supported by empirical evidence. Unfortunately, such evidence is still lacking. [@esist-2013]

Proponents of dynamic languages criticize static ones as being too rigid and cumbersome to work with. The other camp
complains that dynamic languages offer little protection against logical errors and let too many of the errors
happen at runtime. I'll discuss each approach separately in a later section.

Terms like "strongly typed" and "weakly typed" are also in wide use but their meaning is not clearly defined and are
often used to mean certain combinations of language attributes. They are used to refer to how much implicit type conversion
(also known as "coercion") is done by the language, or if the it prevents memory-safety bugs (array bounds checking or use-after-free)
or if type checking is done statically or dynamically. It is best to avoid these ambiguous terms.

## Type checking algorithms
The general idea behind type checking algorithms is the following:

1. Parse the source code into an "Abstract Syntax Tree" (AST)
2. Annotate each node in the AST with a "type annotation"
3. Generate constraints: enumerate all the known relations between the types of the nodes.
4. Use constraint solving to see if the constraints can be satisfied.

**TODO: more detail on type checking algorithms?**

## Static type checking
Programmers make errors. Advanced programming languages should allow the automatic checking of inconsistencies
in programs. The most popular of these consistency checks is called static type checking (or static typing).

> We do static checking without any input to the program [@cse-341, p. 13]

Static type systems help us detect programming errors even before we could run our programs.
It is not just the simple mistakes (like forgetting toconvert a string to a number) that can be caught by a type checker.
A language with a rich set of types offers the opportunity to encode complex information about structure in terms of types
but it requires attention and willingness from the programmer to make good use of the language's facilities.

> The strength of static typing is that it guarantees the absence of type errors in the programs it
> accepts. The weakness of static typing is that it rejects some programs that are in fact correct, but
> too complex to be recognized as such by the type system used. From this tension follows the search
> for more and more expressive type systems [...]
> [@leroy-phd, p. 3]

Static type systems are "conservative", meaning that they sometimes reject programs that actually behave
well at run time. For example

```
if <complex test> then 5 else <type error>
```

will always be rejected as ill-typed even if `<complex test>` always evaluates to true, because
static analysis cannot deftermine that this is the case. [@tapl]
For this reason, they are often criticized as too rigid: static type systems might reject programs that 
never produce type errors in practice.

> ... [static typing] ... consists in detecting a
> large family of errors: the application of operations to objects over which they are not defined [...]
> This is achieved by grouping the
> objects handled by the program into classes: the types, and by abstractly simulating the execution
> at the level of types, following a set of rules called the type system.
> [@leroy-phd, p. 3]

Static languages usually don't allow rebinding a variable to an object of a different type during run-time.
This is what makes static type checking possible (and effective). [@py-s-vs-d]

### Advantages of static languages

#### Early feedback and correctness
> Good types lead to better code maintainability, faster failure on bad code [...]
> [@abrahamson-quora]

...

> Compiler-imposed constraints on data types encouraged rigorous coding and precise thinking.
> [@oracle-generics]

#### Performance
> Static typing guarantees certain properties and invariants on the data manipulated by the program;
> the compiler can take advantage of these semantic guarantees to generate better code [@leroy-intro-tic98, p. 1]

To generate efficient machine code, precise knowledge about the size of the data is required. This can be derived from
static type information - memory size and layout. Languages without static typing cannot be compiled as efficiently,
all data representations must fit a default size. [@leroy-intro-tic98]

> In general, accurate type information at compile time leads to the
> application of the appropriate operations at run time without the need of expensive tests. [@cardelli-96, p. 6]

If a language's type system doesn't allow casts between incompatible pointer types, then those can't point to the
same location in memory which in turn guarantees that load/store operations through those pointers cannot interfere.
This allows the compiler to do more aggressive instruction scheduling. [@leroy-intro-tic98]

> Not having static type system information makes it hard to model control flow in the compiler,
> which leads to overly conservative optimizers. [@duffy-error-model]

Type information is also useful in the optimization of method dispatch in object-oriented languages. [@leroy-intro-tic98]

> General method dispatch is an expensive operation, involving a run-time lookup of the code associated to the method in
> the object’s method suite, followed by a costly indirect jump to that code. In a class-based language, if the actual
> class to which the object belongs is known at compile-time, a more efficient direct invocation of the method code can be
> generated instead. [@leroy-intro-tic98 p. 1]

The ML Kit compiler features a so called "region inference algorith" which is a static analysis technique
to examine the lifetime of dynamically allocated values in a prgram that makes it possible to replace garbage collection with
stack-based memory management. [@region-inference]

> Region inference restores the coupling of allocation and deallocation; after region inference,
> lifetimes are explicit as block structure in the program, making it easier to reason about memory usage [...]
> in some cases, the compiler can prove the absence of memory leaks or warn about the possibility of memory leaks
> [@region-inference, p. 725.]

#### Documentation
> "The comment is lying!" - senior programmer

Source code comments usually get ignored when updating a code segment
they refer to and since they don't have any meaning in the program, the runtime or the compiler
can't give any warning about updating them: they "drift" from the code, often stating the exact opposite of what is implemented.

> Types are also useful when reading programs. The type declarations in procedure
> headers and module interfaces constitute a form of documentation, giving useful hints
> about behavior. [@tapl, p. 5]

Explicit type declarations are "living documentation". Type annotations provide information about the
code and since they are verified by the typechecker they cannot drift, they always stay up to date.

> Static type systems build ideas that help explain a system and what it does. [...]
> They capture information about the inputs and outputs of various functions and modules. [...]
> It's documentation that doesn't need to be maintained or even written. [@debating-type-systems]

## Dynamic type checking
> Even statically checked languages usually need to perform tests at run time to achieve safety. [...]
> The fact that a language is statically checked does not necessarily mean that execution can proceed entirely blindly.
> [@cardelli-96, p. 3]

In dynamically typed languages the types of program constructs don't have to be associated with a fixed type.
Such languages let us, for example define functions that can accept multiple types of values. The exact type of the arguments
will only be known when the program is running and if the types don't match the operations performed
on them, they only report that at run-time.
Such languages don't attempt static checks. In order to maintain type safety (prevent unintended program behavior) these
languages instead perform various dynamic (run-time) checks to make sure that the data structures of
the program stay consistent. Typical runtime checks include

- division-by-zero checks
- array bounds checking,
- verifying if a downcast is valid or not
- null pointer dereference check

When a dynamic check fails, the language runtime produces a runtime error. It depends on the language if a certain
runtim error is recoverable or not: the language may allow the programmer to write error handling code and
resume program execution after the error was handled. [@wiki-type-systems]

> We need to come to terms with persistency, inconsistency and change in programming
> languages. This means that dynamic programming languages should
> support the notion of software as living, changing systems, they should provide
> support multiple and possibly inconsistent viewpoints of these systems. Static
> type systems still have their place, but they should serve rather than hinder expressiveness.
> [@revival-2005, p. 10]

### Advantages of dynamic languages

#### Quick and easy to write and read
Dynamic languages have rapid edit-run cycles (there is no upfront compilation before running the program).
In the absence of a pre-runtime type checking phase, these languages favor prototyping and
agile software development where creating proof-of-concept systems quickly are crucial.
The code is free of type annotations and casting which makes it easier to write and read which can help maintainability.

#### Flexibility
A dynamic type system can help write more modular and decoupled code which may lead to a more flexible design.
Dynamic typing encourages "generic code", code that is not "tightened down", free of fixed types that helps to think more abstractly.
Module boundaries (the types, structures, interfaces that each module expects to see from another one) are not fixed down
so it becomes possible to "plug in" other modules that may provide the required set of constructs without having to
match them together. Modifying modules to meet interface requirements of other modules can be done incrementally.

> Dynamic languages are more tolerant to change; code refactors tend to be more localized (they have a smaller area of effect)
> [@hackernoon-s-vs-d]

# Type systems in the real world
In this section I'll introduce type systems concepts from simpler to more advanced and how they appear in real, popular programming languages.
There is a great deal of difference in how static and dynamic languages make use of types. Some concepts might make
no sense in one context, while others might be used in both so let's clarify a few things first.

For static languages, the whole point of having type systems is to help us put constraints on parts of our code
and have some automated tool (the typechecker) verify that our constraints hold across our program.
To make the most of the typechecker, we try to define as much of our program as we
can in terms of types. Different static languages provide different facilities for defining types and connections between them.

Dynamic languages must know the types of their values to do run-time checks in order to avoid illegal or undefined operations.
In dynamic languages this is done by attaching a type label to every run-time value.

In the following section, I'll dive into how certain type systems concept appear in programming languages and how we can
leverage these facilities to increase correctness in our code.

## No types - most assembly languages
An assembly language is one where there is a strong correspondence between the language's instructions and the instructions
of the machine's instruction set architecture (ISA). That is, most languge constructs have a 1-to-1 mapping to a CPU instruction.
Since there are many types of different CPU ISAs, there are also many different assembly languages.
There are some so called typed assembly languages (TAL) mostly within academic circles, but most assembly languages are 
said to be untyped.

Even though assembly supports certain basic data types, even arrays, structures and functions, it is mostly about defining
the memory layout of the values. In assembly, we can't associate operations with types.
In short, there is nothing to type check. This is the main point of assembly: manipulating data at the lowest level, giving
access to individual bytes to the programmer.

Also, there are assembly languages that were designed to be compiler targets rather than used by programmers directly.
For such languages there is little benefit for complex typing.

**TODO: read more about assembly, come back to this section later**
**TODO: x86-64 Assembly Language Programming with Ubuntu (currently at p. 34)**

Assembly languages are - barring some academic derivatives - untyped. The values that we can manipulate in the language
are just byte sequences. There is no way of knowing what a register or memory address holds just by looking at the assembly code.
A given bit pattern may have multiple valid interpretations as different types. A certain system call might expect an 8 byte integer
value for printing, but an 8byte floating-point value can also be interpreted as an integer.
Assemblers don't try to check for matching types.

**TODO: Explain why assembly has no types! Are there any advantages of not having types?**

Typed Assembly Language papers (from around 1999) - Morrisett et al.
    - http://www.cs.cornell.edu/talc/papers.html
    - https://www.cs.princeton.edu/~dpw/papers/tal-toplas.pdf
    - https://www.cis.upenn.edu/~stevez/papers/MCGG99.pdf

## Types and operations
The next step for a programming langage with regards to type systems would be to define certain basic types and operations
for the values in the program. These help reduce the cognitive load on the programmer and make it possible to check
(either statically or dynamicall) whether some operation later in the code is considered legal or not.
Today we take for granted such a type system but this indeed is a language feature that wasn't there for the
first generations of computer programmers.

**TODO**

## Gradual typing
Gradual typing orignates in Siek & Taha's [@siek-taha-gradual] 2006 paper. The idea is that a language should provide
static and dynamic typing at the same time with the programmer controlling the degree of static checking by annotating function parameters
with types [@siek-taha-gradual]. Gradually typed languages usually (but not always) have an interesting property:
an unsound type system, as is the case with TypeScript:

> The designers of TypeScript made a conscious decision not to insist on static soundness. [...]
> it is possible for a program, even one with abundant type annotations, to pass the TypeScript typechecker but to fail
> at run-time with a dynamic type error [...]
> This decision stems from the widespread usage of TypeScript to ascribe types to existing JavaScript libraries and codebases,
> not just code written from scratch in TypeScript. It is crucial to the usability of the language that it allows for common
> patterns in popular APIs, even if that means embracing unsoundness in specific places
> [@understanding-ts]

As Bierman et al. [@understanding-ts] put it, it is a valid choice to go with a deliberately unsound type system in the case
of gradually typed languages. This makes it possible to use it on existing large codebases that might contain possibilities
for type errors at runtime (maybe only in unrealistic scenarios) but that still benefit from the added static type checking.
[@uiut]

### Gradual typing in TypeScript
TypeScript is a gradually typed superset of the JavaScript language with optional type annotations and provides a typechecker and transpiler
for JavaScript programs. Thanks to its type inference, every valid JavaScript program is also a valid TypeScript program
so it is possible to gradually transform a JavaScript codebase into a TypeScript one. TypeScript's static type system is unsound by design
to allow for "backwards compatibility" and an incremental transition from dynamically typed JavaScript codebases.

**TODO: example from:**
- https://www.typescriptlang.org/docs/handbook/type-compatibility.html
    - look for "unsound" keyword!

### Optional type annotations in Python 3
Even though Python 3 is dynamically typed, the language allows optional "type hints" which are similar to
type declarations in languages like Java. These annotations may be used together with type checkers like `mypy`,
`pyre-check` or `pytype` [@py-type]. The programmer is free to annotate only parts of the source code.
The Python 3 runtime itself doesn't typecheck the type hints. Due to python's dynamic nature,
the following code will be executed without any type errors in Python 3.5.2:

~~~{.python}
def f(a: int, b: int) -> str:
    return a + b

print(f("x", "y"))
print(f(1, 2))
~~~

The programmer has to use one of the external type checkers to make use of type hints. Running `mypy`
on the above code indeed reports type errors complaining about an incompatible return type declaration and incompatible
argument types when calling the the function with integer values.

In my own experience, on one hand, gradual typing tends to make the programmer lazy. Omitting type annotations can help finish writing certain parts
of the program faster. The program might even run without error when tested. The problem is that we likely didn't cover all the
possible execution paths and by "shutting down" the typechecker we made it harder to find the possible inconsistencies in the code.
The program seems to behave correctly but had we defined types properly, we could have been warned about type errors
that will now show themselves later at an unexpected time.

On the other hand, having the possibility of retrofitting a codebase with static type checking is always good.
Adding some type safety a step at a time to an existing large code base by providing a smooth transition and thus
not blocking development can provide great value.

### Structural vs Nominal typing
Structural typing is a way of relating types based solely on their members. Structural typing requires
that a type supports a given set of operations. [@so-svic-typing]

Duck typing is a loose form of structural typing: the implementation must be provided at run-time, not necessarily at compile time.
There are no explicitly defined interfaces in the language which makes for terse and concise code as well as minimal coupling
between different modules. Unfortunately, it also hides the dependencies between classes. [@nascimento-duck]
The phrase comes from the American poet, James Whitcomb Riley's duck test:
"if it walks like a duck, and quacks like a duck, then it probably is a duck".

> In duck typing a statement calling a method on an object does not rely on the declared type of the object; only that the object,
> of whatever type, must supply an implementation of the method called, when called, at run-time.
> [@wiki-type-systems]

Structural typing is in contrast with nominal typing. In the case of a nominally-typed language,
a subtype must explicitly declare itself to be related to the supertype. Nominal is more strict than structural.
[@typescript-docs]

## Polymorphic typing - "Polymorphism"
A language, where every expression has a single type is called monomorphic. In such a language
there is a distinct identity function of each type: $\lambda \ (x : \tau ) \ x$ even though the
behavior is exactly the same for each choice if $\tau$. Although they all have the same
behavior when executed, each choice requires a different program. [@pfpl-2016]

> [...] motivated by a simple practical problem (how to avoid writing redundant code),
> the concept of polymorphism is central to an impressive variety of seemingly disparate concepts [...]
> [@pfpl-2016 p. 141.]

Polymorphism (poly = many, morph = form) is the concept of having internally different objects that provide the same interface.
Even though they implement different behaviour and have different structure, in some aspect they "look the same" from the outside
and so they can be used interchangeably. It is the programmer's task to declare such similarities
between different types. Of course it is not only about declaring similarity; the programmer has to
create some structure like implementing a common method or placing the types in the same hierarchy
or wrapping them with the same structure. The way we do this is by using some sort of polymorphism that
the language at hand provides. The point of the whole thing is to decaler similarity and iterchangeability
on the type level so that we can utilize the type checker. 

To facilitate code-reuse, most programming languages feature a polymorphic type system.
A polymorphic languages are those of which the type systems allows different data types to be handled
in a uniform interface. [@ots-2008] Stated more simply: in a polymorphic language, a program fragment
may have multiple types. There are different kinds of polymorphisms, I will look at each of them in
more detail below.

### Ad-hoc polymorphism - overloading
Ad-hoc polymorphism means polymorphic functions, that is, functions that can be applied to different types of arguments and
the implementation depends on the types of the arguments.
Ad-hoc here means that this is not a feature of the type system but instead a mechanism that is about using
the same name for different (but related) operations. [@wiki-polymorphism]
The typical example are method or operator overloading in most OOP languages. Method overloading is the provision of different
implementations depending on the type of arguments the method (function) is called on and this can happen statically or dynamicall. [@tapl]

### Subtype polymorphism - Subtyping
Subtype polymorphism or runtime polymorphism is the process of taking a type (the base type)
and defining a more specialised type (the subtype) based on it by extending it with functionality or
overriding some parts to facilitate code reuse.
The subtype is related to the supertype by the notion of substitutability which means that in a program the subtype
should be able to be used wherever the supertype is expected. [@wiki-subtyping]
In most classical object oriented languages subtyping is tied to inheritance in the form of class hierarchies.
Class hierarchies together with method overriding (providing different or extended implementations in child classes)
is the primary vehicle of subtype polymorphism that is made possible by dynamic method dispatch.

Interfaces in OOP languages also implement something like subtype polymorphism: they provide a common type for
types that may not otherwise be related.

#### Difference between subtyping and inheritance
Go is a good example of how subtyping is a different concept from inheritance.
In Go, structs (a collection of related attributes) with methods resemble classes of classical OOP languages but in Go there is
no subtype polymorphism (or any kind of polymorphism) for stucts. Struct types can embed other stuct types where the embedder type
gains access to the methods of the embedded type. This provides a limited form of inheritance. The embedder
type however is not polymorphic with the embedded one (it doesn't become a subtype of the embedded one).

In Go, we use interfaces to declare subtype relationships. An interface is a set of function signatures and any type
that implmenets all the functions ("methods") that an interface declares is said to implicitly implement
that interface - also a case of structural (instead of nominal, as in most OOP languages) subtyping.

Most programmers are trained to think in a classical
object oriented way where derived classes not just inherit from, but also become subtypes of their parents.
I also come from such a backgroud and in my experience, learning the basics of Go and using it in a procedural style
is simple. Once we had to write more complex type relationships and resort to the language's object oriented features,
it became much harder and I was stuck for a good while trying to understand how my well-understood OOP object hierarchies
can be expressed with this language.

**TODO: go snippet with interface-based polymorphism**

### Parametric polymorphism
Sometimes called "compile-time polymorphism", parametric polymorphism means that concrete types are abstracted away
from the implementation and type parameters (or type arguments) are used instead. This way type checking can still be done
based on type variables while providing flexibility since they can take on any type as long as that type is used
consistently within the scope of the type parameters. The simplest use case for parametric polymorphism is implementing
generic "container" types in statically typed languages where the emphasis is not on the type of the values in the container
but instead on their consistent use within the container (generic lists, generic tuples). The typechecker can aid
in enforcing the consistent usage without dictating the exact types of the values.

#### Generics
**TODO: any meaning in a dynamic context?**
    - https://www.quora.com/Do-generics-makes-more-sense-in-statically-typed-or-in-dynamically-typed-languages-Explain-your-answer

http://www.angelikalanger.com/GenericsFAQ/FAQSections/Fundamentals.html
    - link from the above: http://www.angelikalanger.com/GenericsFAQ/FAQSections/TechnicalDetails.html#Why%20does%20the%20compiler%20add%20casts%20when%20it%20translates%20generics?

**TODO: after a few words on "Generics (Java, C#), write an example of parametric polymorphism in Java and one in Elm, compare them!**
**some guidelines: https://stackoverflow.com/a/42417159/1772429**

## Reflection
> Many programming languages require compiled programs to manipulate some amount
> of type information at run-time [@leroy-intro-tic98 p. 4]

Reflection is an umbrella term for programming language features that allow us to inspect
and modify a program while it is running.
It is an inherently dynamic process and so it conflicts with many of the principles of statically typed languages.
Most static programming languages do provide reflection facilities, but with limited support because
it is essentially a way of circumventing the static type system.

> Reflection enables the changing of systems without the need to rebuild or even restart them.
> This is an important basis for building the dynamic sytems of the future: Mobile, Ubiquitous, Always-On.
> [@revival-2005, p. 6]

When used cautiously, reflection can give the programmer power over parts of a program that would not otherwise
be accessible by the runtime like internals of private/protected components or 3rd party libraries.
However, a totally reflective (dynamic) system with "unscoped" reflection suffers from many disadvantages:

- Security: The clients that use reflection can do anything
- Stability: The effects of reflection are global. One client using reflection affects the other clients
- Performance: Full reflection is costly.

To solve the above issues, the reflective capabilities of the language must be scoped:

- define when and where reflection should be available
- limit the reflective interface to certain clients
- constrain the effects of reflection

[@revival-2005]

Reflection can help with serialization (or "marshalling") of objects when the objects themselves were originally not designed
to support it and it would be too tedious to prepare a hierarchy of classes for serialization.
Debuggers or class browsers can be created using reflection. Object-relational mappers (ORM) that
create object oriented abstractions of database entities are popular in business software and are another
use case for reflection. Testing frameworks that are based on naming conventions also depend on reflection
to dynamically discover methods which follow a certain naming pattern.

**TODO: add code snippet**
**this maybe: https://missingquitbutton.wordpress.com/2019/07/20/using-reflection-with-serialization-and-deserialization-part-1/**

## Type classes

**TODO**
https://jrsinclair.com/articles/2019/type-classes-what-i-wish-someone-had-explained-about-functional-programming/

## Ownership
The ownership system is one of the main innovations of the Rust programming language, whereby it can statically determine
when a memory object is no longer in use. Through ownership, Rust provides memory safety guarantees at compilation time.

> All programs have to manage the way they use a computer’s memory while running.
> Some languages have garbage collection that constantly looks for no longer used memory as the program runs;
> in other languages, the programmer must explicitly allocate and free the memory.
> Rust uses a third approach: memory is managed through a system of ownership with
> a set of rules that the compiler checks at compile time.
> [@rust-book]

Memory safety means that the software never accesses invalid memory. Such invalid memory accesses could be use-after-free,
null pointer dereferencing, using uninitialized memory, double free or buffer overflows [@mozilla-fearless], all of which
are common causes of severe bugs and vulnerabilities. Providing memory safety is considered as one of the next big challanges
of programming language design.

**TODO: stanford lecture notes on Memory Safety: https://stanford-cs242.github.io/f19/lectures/06-2-memory-safety.html**
**TODO: the linked paper: "affine type system": https://gankra.github.io/blah/linear-rust/**
**TODO: nice paper: https://sergio.bz/docs/rusty-types-2016.pdf**

## Effect systems
- downloaded PDF: "Type and effect systems - Nielson"
- https://www.stephendiehl.com/posts/exotic03.html
- https://en.wikipedia.org/wiki/Effect_system

## Typestate
https://docs.rust-embedded.org/book/static-guarantees/typestate-programming.html

**TODO**

## Region types

**TODO**

## Linear types

**TODO**

## Variance

**TODO: Remove unless some good content is found!**

- invariance
- covariance
- contravariance

https://medium.com/@yuhuan/covariance-and-contravariance-in-java-6d9bfb7f6b8e
https://blog.daftcode.pl/csi-python-type-system-episode-1-1c2ee1f8047c
https://blog.daftcode.pl/csi-python-type-system-episode-2-baf5168038c0
https://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)
https://en.wikipedia.org/wiki/Covariant_return_type

## Concrete vs abstract types
Most programming languages differentiate between concrete and abstract types.
A concrete type corresponds to the concept of a "data structure", a collection of data values and the relationships between them.
A concrete type in a programming language precisely defines the memory layout of the data that objects of that type hold.

Abstract types correspond to the concept of an "abstract data type" (ADTs) which is a mathematical model of a type.
An ADT defines a type by its behavior from the point of view of its user. [@wiki-abstract], [@tt-oop]

> An ADT's user need not know how the object it represents is implemented [...]
> In addition to the intellectual leverage for programmers who can take bigger strides in their thoughts,
> it provides flexibility in modifying the ADT implementation [@tt-oop, p. 34]

An abstract type defines behavior. It defines an "interface", a set of "calls" to which the
objects of that type respond to. It describes how to interact with that object.
Abstract types manifest themself in a number of different ways in programming languages:

- interfaces
- abstract classes
- pure virtual functions

Abstract types are related to but should not be confused with the general concept of "abstraction".

## Type inference
Type reconstruction or informally, type inference is the process of automatically (instead of manually, by the programmer) assigning types
to expressions in a program by examining the operations that are performed on them.

> The first statically typed languages were explicitly typed by necessity.
> However, type inference algorithms - techniques for looking at source code with no type declarations at all,
> and deciding what the types of its variables are - have existed for many years now
> [@debating-type-systems]

Type inference should not to be confused with dynamic typing.
Even though types may not be visible in the source code in an inferred language, it might check those type statically (before execution).

The challenge of type inference is not assigning a type to untyped terms in a program, but rather to find the balance between the
most general and most specific type that could have been declared in the program.
[@type-inf-ml]

By utilizing type inference, code written in the language can be more concise and more easily understandable.
Having to spell out complex types can be a burden and can hurt readability and often provide no benefit.
Type inference seems to be the golden mean: making static type checking possible while not enforcing the programmer
to be explicit about their types.

## Dependent types
Dependent types are based on the idea of using scalars or values to more precisely describe the type
of some other value. [@wiki-type-systems] Dependent types can express the rules of matrix multiplication:

\begin{equation*}
    \frac{\Gamma \vdash A : matrix(l,m), \ \Gamma \vdash B : matrix(m,n)}{\Gamma \vdash A \times B : matrix(l,n)}
\end{equation*}

Which we read as "if $A$ is an $l \times m$ matrix and $B$ is a $m \times n$ matrix, then their product is an $l \times n$ matrix".

The scalar values that the types depend on must not be constant values...
**TODO: read all of these! good material!**
- https://cs.stackexchange.com/a/40098/30429
- https://softwareengineering.stackexchange.com/a/401220/90623

**TODO: revise after having tried such a language!**

## Algebraic data types
Algebraic data types are composite types: they are defined as a combination of other types.
There are two main classes of algebraic data types: product types and sum types. Product types are structures
that can hold more than one value in a single structure at the same time. This is just a fancy name for common and simple
programming language constructs like tuples or records (maps or structs). Product type are not particularly interesting
from a type systems standpoint but sum types very much are.
[@wiki-algebraic]
[@sinclair-algebraic]

### Sum types
To understand sum types (also called tagged unions or variant types), first lets define union types.
Union types are usually denoted as `A | B` where `A` and `B` are some types.
A union type between two types `A` and `B` is simply the union of the two sets of values,
so it may hold any value from either `A` or `B`. For example, the union type `null | int` can hold
`null` or any integer value. [@waleed-union-vs-sum]

Sum types are very similar to union types as in they hold a value that must be one of a fixed set of options.

> Only one of the types can be in use at any one time, and a tag field explicitly indicates which one is in use.
> It can be thought of as a type that has several “cases,” each of which should be handled correctly when that type is manipulated.
> [@wiki-tagged-union]

Before I get into more details, for reference, here is an example of a sum type definiton in Elm (an ML type language):

```
type Message
  = InitApp
  | AddNewRow
  | DeleteRow Int
  | InputChanged Int Attribute String
```

I especially like the ML syntax because it is intuitive: this must be about some message type that can take
on certain forms where each form contains different data about the message.

Every type in the sum type is accompanied by a label (or tag), hence the name "tagged union".
This label is a unique identifier for this element of the sum type.
A sum type can also be thought of as an enum, with a payload where that payload is the actual value that it holds.
[@waleed-union-vs-sum]
[@waghorn-sum-types]

> [A tagged union is] a union, but each element remembers what set it came from
> [@waleed-union-vs-sum]

**TODO: talk about how sum types facilitate null-tracking and error handling and whatnot**
https://blog.waleedkhan.name/union-vs-sum-types/

- https://www.dragonwasrobot.com/functional-programming/2016/12/20/sum-types-in-kotlin-elixir-and-elm.html
- idea: implement a queue with sum types in some ML language

- Maybe / Option
    - note: "nullable" in dynamic languages where ther is NULL, "option" or "maybe" in static languages
    - Null pointer exceptions vs. "Maybe" types
        - https://guide.elm-lang.org/error_handling/maybe.html

### Applications
In most imperative languages conditional expressions (if-else statements) can define any number of branches
that are not checked for consistency. Execution enters these branches based solely on their predicates,
boolean valued "functions". This means that by mistake, they can overlap or fail to handle all possible cases.
In functional languages, with the help of pattern matching, algebraic data types facilitate a type safe
implementation of conditional expressions. They let us define the branching logic in terms 
of a composite type and allow the type system to check whether we we covered all the cases. [@parmer-type-systems]

**TODO: talk about null-tracking as described here: https://blog.waleedkhan.name/union-vs-sum-types/**

https://www.youtube.com/watch?v=2wZ1pCpJUIM
- rust part begins at `25:05`
- algebraic data types `29:40`
    - **Algebraic types allow robust, concise error handling** - what does this mean? why?

## Type-level programming

**TODO: do this only if good material is available**

https://docs.rust-embedded.org/book/static-guarantees/typestate-programming.html

# Summary
In my own experience, a statically typed language is a better tool for writing good, working software.
I am surprised by the lack of evidence that can back this claim. In fact, all the studies I could find conclude that there is no objective, measurable
difference between the quality of software produced with dynamicall or statically typed languages.
This suggests that it is a matter of personal taste that someone might feel more productive or confident with one or the other.

In my view (which might change in the future) dynamic languages do have their place which is small-scale sofware development, typically small services
or scripts that are not expected to grow much. The small size usually means a smaller "input space", less things to go wrong
and less things in which a static type system might really help and on the other hand, being free from type constraints
increases the speed of development.
Dynamic languages offer a low barrier to entry and agility that provides quick results with short development times.

Many originally dynamic languages (javascript, python, ruby, php) seem to be adding support for some form of optional typing later in their
development, this suggests a dissatisfaction with dynamic typing as projects grow larger.

**TODO: continue!**

# Suggestions for further research: Type systems and software security

**TODO: put all the interesting stuff here that I had no time for**

- defensive mechanisms provided by type systems
    - look at the most common sources of vulnerabilities, see if type systems could help
        - need data!
- solving injection with a type system
    - http://blog.moertel.com/posts/2006-10-18-a-type-based-solution-to-the-strings-problem.html

## Type-directed memory management

> the work of Martin Hofmann and the team on the Mobile Resource Guarantees project, who made type-directed memory (de/re)allocation a major theme
> https://stackoverflow.com/a/7039396/1772429

## Region inference

> Region inference is a technique for determining when objects become dead (even if they are reachable) by a static analysis of the program.
> https://www.memorymanagement.org/glossary/r.html#term-region-inference

**TODO: summarize CAR Hoare's presentation on `NullPointerException`s (The Billion Dollar Mistake - 2009)**

- https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare
- 31:10 great notes about what to expect from programming languages
- 31:40 "formal verification"
- 37:34 "now, the real commercial imperative which requires greater attention paid to formal correctness of the programs is the virus."
    - "it reaches paths of your program that normal execution never reaches"
    - "it's no longer adequate to test your program against all the cases that are likely to arise..."
- 50:00 great thoughts about the `jmp` machine instruction

...

\pagebreak

# References
