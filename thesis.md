---
title: "A survey of type systems in programming languages"
subtitle: "Óbudai Egyetem - Neumann János Informatikai Kar, mérnökinformatikus szak"
author: "András Sallai"
date: "2019"
keywords: [Type systems, Programming languages]
...

\pagebreak

\tableofcontents

\pagebreak

# Introduction, personal motivation
After having worked only with dynamic languages for a few years, when I first started using
staticly typed languages (C# and java in my case) I was struck by how much their
type system and typechecker helped write code more effectively and more confidently.
The type system made me think more thoroughly, it allowed me to change parts
of the program and be confident that it was still working as expected.
It was a different, a much more pleasant way of writing software than I had done before.
I became more and more interested in the possibilities of static checking and type systems.
I started wondering what else was out there that could increase programmer productivity
and software quality. This curiosity led me to choosing type systems as the topic of my thesis.

My goal with this thesis is to gain a more fundamental understanding of programming languages,
the structures and algorithms behind them.
First, I'll survey the history and theoretical background of type systems.
I'll look at how type systems evolved, and how they can be categorized.
I'll compare the type systems of widely used programming languages and will try to
give an overview of the possibilities of recent advances in type systems and programming language design.

\pagebreak

# Type systems
> Modern software engineering recognizes a broad range of formal methods for helping ensure that a system behaves correctly [...]
> by far the most popular and best established lightweight formal methods are type systems.
> [@pierce-types-and-prog, p. 1]

A type system is a set of rules that associate a property called a type to various constructs in a computer program.
A type defines a range of values as well as possible operations on instances of that type.

> A type is simply a property with which a program is implicitly or explicitly annotated before runtime.
> Type declarations are invariants that hold for all executions of a program, and can be expressed
> as statements such as “this variable always holds a String object,” or “this function
> always returns a tree expression.” [@ppl-2016, p. 100]

The main purpose of type systems is to reduce possibilities for bugs in computer programs.
The type system associates a type with each value in the program and then by examining the flow of these values
attempts to prove that no operation violates them.

Such a violation is called a type error. It is an inconsistency in a program according to the type system's rules.
Exactly what constitutes a type error is defined by the type system of the language.
A program that violates the rules of its type system is often called ill typed. A program that conforms
to the rules of the language's type system is a well typed program. [@wiki-type-systems]

> Type systems are used to define the notion of well typing, which is itself a static approximation of good behavior [...]
> Well typing further facilitates program development by trapping execution errors before run time. [@cardelli-96, p. 6]

Languages where variables can be given (nontrivial) types are called typed languages.
Languages that don't restrict the range of variables are called untyped languages. In these languages, invalid operations
might be applied to values which could result in a fixed value, a fault, an exception or an unspecified effect.

Typed languages can enforce good behavior by performing static (i.e. compile time) checks to prevent ill typed
programs from ever running. Untyped languages can enforce good behavior by performing sufficiently detailed
runtime checks to rule out errors. For example, they may check array bounds or division operations and generate
recoverable exceptions. This checking process during runtime is called dynamic checking.
[@cardelli-96]

> Even statically checked languages usually need to perform tests at run time to achieve safety. [...]
> The fact that a language is statically checked does not necessarily mean that execution can proceed entirely blindly.
> [@cardelli-96, p. 3]

By using the facilities provided by the type system, we can add more information in our programs.
We can create a safety-net against execution errors by making it possible for automated tools to verify the steps
we take throughout our code.
Through types, we can add more meaning, a deeper, more solid structure. That structure aids
us when we later change parts of the program or add new components to it.

Type systems are the glue between mathematical logic and computer programs. They make it possible to
prove that our programs behave correctly. Advanced, sophisticated type systems allow us to express
a finer, more precise structure and thus more properties of our sofware may be proven by automated tools
at compile time and more optimization may be carried out to improve runtime performance.

## Type theory
Type theory is a branch of mathematical symbolic logic: a system of representing logical expressions
through the use of symbols. It was concieved in the beginning of the 20th century by Bertrand Russell
in order to resolve contradictions present in his set theory. Type theories (there are many,
like Alonzo Church's Simply Typed Lambda calculus or Per Martin-Löf's Intuitionistic Type Theory)
are formal systems which means they define rules for inferring theorems (statements) from axioms.
[@stanford-tt]

> Type theory is a formal language, essentially a set of rules for rewriting certain strings of
> symbols, that describes the introduction of types and their terms, and computations with these, in a sensible way.
> [@ncatlab-tt]

Type theory lays down the theoretical foudation for the type systems found in programming languages and
the typechecking algorithms behind them.

## Language safety

> A safe language is one that protects its own abstractions [...]
> Every high-level language provides abstractions of machine services. Safety refers to the language’s
> ability to guarantee the integrity of these abstractions and of higher-level abstractions
> introduced by the programmer using the definitional facilities of the language.
> [@pierce-types-and-prog, p. 6]

As [@pierce-types-and-prog] puts it, the abstraction of a safe language can be used "abstractly", whereas in an unsafe language
it is necessary to keep in mind the low level details, like how data is structured in memory or how allocations take place
in order to understand how the program might misbehave.

Note that "language safety" can be achieved by static type checking but also by run-time checks, like array-bounds checking is
performed by many languages during runtime.

Chappell [@types-primer] says that a programming language or language construct is type-safe if it forbids
operations that are incorrect for the types on which they operate. The author notes that some languages
may discourage incorrect operations or make them difficult without completely forbidding them so
we may compare the level of type safety offered by two programming languages.

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
Informally, safe languages are often referred to as "strongly typed".

### Preservation and progress
Formally, a language can be called type safe if the following properties hold:

\begin{enumerate}
  \item If $e : \tau$ and $e \rightarrow e'$, then $e' : \tau$
  \item If $e : \tau$, then either $e$ is a value or there exists $e'$ such that $e \rightarrow e'$
\end{enumerate}

The first property is called "preservation": it states that evaluation preserves the type of an expression.
The second property is called progress, it states that a well typed expression is either a value or it can be evaluated
further (until it is reduced to value). Type safety is the conjunction of preservation and progress. [@pfpl-2016]

Note that safety is not a property of a type system, but that of a language. There are operations that
would pass type checking but produce an error during runtime, like division by zero. Enhancing a type system
so that it could protect against division by zero erros would make it too restrictive (too many programs would
be ruled out as ill-formed). It is not possible to predict statically that an expression would evaluate to zero,
so if we want our language to be safe, we need to add dynamic (runtime) checks. Even though it is not part
of the static type system, such a language is still considered safe. [@pfpl-2016]

### Should languages be safe?

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

The question arises: are there languages that provide both safety and performance at the same time?
I'll get back to this when discussing "Type systems and program performance".

**TODO: "are unsound type systems wrong?" http://frenchy64.github.io/2018/04/07/unsoundness-in-untyped-types.html**

## Formalization of type systems

> How can we guarantee that well typed programs are really well behaved? [...]
> Formal type systems are the mathematical characterizations of the informal type systems
> that are described in programming language manuals. Once a type system is formalized, we can
> attempt to prove a type soundness theorem stating that well typed programs are well behaved.
> If such a soundness theorem holds, we say that the type system is sound.
> [@cardelli-96, p. 7]

Most materials on the formalization of type systems are dense and get very abstract quickly.
Here, I'd like to briefly introduce the basic concepts and standard notation used when
discussing formal type systems. Hopefully, by the end of this introduction I'll have presented
just enough theoretical foudation that I can also talk about what this leads to in practice.

### Judgements and rules

An expression is a syntactically correct fragment of a program that can be evaluated to a value.
Type systems associate expressions with types. We call this the _has type_ relationship:
$e : M$, where expression $e$ has type $M$. This is called a judgement.

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

In a program, the type of a variable can only be decided by looking at its context (or environment) which is defined by
the declarations of the variables. We can think of context as a lookup table of (variable, type) pairs:

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

If we can constrcut a derivation for a judgement then we can say that the judgement is valid.

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

# Type checking

Type checking is the process of deciding whether a term is well typed or not.
A type checker verifies that the constraints posed by the type system are not violated
by the program. Type checking can be done by automated tools called typecheckers, which are usually
built into compilers or linkers. [@debating-type-systems]

There are two main branches of languages with regards to type checking (or "typing"): static and dynamic.
Staticly typed languages carry out type checking before the program is actually run.
Dynamically typed languages do type checking during run-time. Both sides have their advantages and disadvantages.

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
happen at runtime.

## Type checking algorithms

...

[link](letswrite)

[letswrite]: https://speakerdeck.com/igstan/lets-write-a-type-checker

In the next section I'll give a brief overview of static and dynamic languages and will later go into much more
details when surveying my selected list of programming languages.

## Static languages
Programmers make errors. Advanced programming languages should allow the automatic checking of inconsistencies
in programs. The most popular of these consistency checks is called static type checking (or static typing).

> The strength of static typing is that it guarantees the absence of type errors in the programs it
> accepts. The weakness of static typing is that it rejects some programs that are in fact correct, but
> too complex to be recognized as such by the type system used. From this tension follows the search
> for more and more expressive type systems [...]
> [@leroy-phd, p. 3]

...

Static type systems help us detect programming errors even before we could run our programs.
It is not just the simple mistakes (like forgetting toconvert a string to a number) that can be caught by a type checker.
A language with a rich set of types offers the opportunity to encode complex information about structure in terms of types
but it requires attention and willingness from the programmer to make good use of the language's facilities.

Static type systems are "conservative", meaning that they sometimes reject programs that actually behave
well at run time. For example

```
if <complex test> then 5 else <type error>
```

will always be rejected as ill-typed even if `<complex test>` always evaluates to true, because
static analysis cannot deftermine that this is the case. [@pierce-types-and-prog]

> ... [static typing] ... consists in detecting a
> large family of errors: the application of operations to objects over which they are not defined [...]
> This is achieved by grouping the
> objects handled by the program into classes: the types, and by abstractly simulating the execution
> at the level of types, following a set of rules called the type system.
> [@leroy-phd, p. 3]

Static languages usually don't allow rebinding a variable to an object of a different type during run-time.
This is what makes static type checking possible (and effective). [@py-s-vs-d]

### Advantages of static languages

...

#### Early feedback and correctness

...

> Compiler-imposed constraints on data types encouraged rigorous coding and precise thinking.
> [@oracle-generics]

#### Performance
**TODO: type systems allowing certain compiler optimizations?**

- https://xavierleroy.org/publi/intro-tic98.pdf

To generate efficient machine code, precise knowledge about the size of the data is required. This can be derived from
static type information - memory size and layout. Languages without static typing cannot be compiled as efficiently,
all data representations must fit a default size.

> In general, accurate type information at compile time leads to the
> application of the appropriate operations at run time without the need of expensive tests. [@cardelli-96, p. 6]

If a language's type system doesn't allow casts between incompatible pointer types, then those can't point to the
same location in memory which in turn guarantees that load/store operations through those pointers cannot interfere.
This allows the compiler to do more aggressive instruction scheduling.

> Not having static type system information makes it hard to model control flow in the compiler,
> which leads to overly conservative optimizers. [@duffy-error-model]

Type information is also useful in the optimization of method dispatch in object-oriented languages. [@leroy-intro-tic98]

> General method dispatch is an expensive operation, involving a run-time lookup of the code associated to the method in
> the object’s method suite, followed by a costly indirect jump to that code. In a class-based language, if the actual
> class to which the object belongs is known at compile-time, a more efficient direct invocation of the method code can be
> generated instead. [@leroy-intro-tic98 p. 1]

#### Documentation

"The comment is lying". Source code comments usually get ignored when updating a code segment
that they refer to and since they don't have any meaning in the program, the runtime or the compiler
can't give any warning about updating them: they "drift" from the code, often stating the exact opposite of what is implemented.

> Types are also useful when reading programs. The type declarations in procedure
> headers and module interfaces constitute a form of documentation, giving useful hints
> about behavior. [@pierce-types-and-prog, p. 5]

Explicit type declarations are "living documentation". Type annotations provide information about the
code and since they are verified by the typechecker they cannot drift.

> Static type systems build ideas that help explain a system and what it does. [...]
> They capture information about the inputs and outputs of various functions and modules. [...]
> It's documentation that doesn't need to be maintained or even written. [@debating-type-systems]

## Dynamic languages

Dynamic (or dynamically typed) languages don't require the programmer to fix the types of the constructs in their programs.
For example, dynamic languages let us define functions that can accept multiple types. The exact type of the arguments
will only be known when the program is running and if the types don't match the operations performed
on them, they only report that at run-time.
Such languages don't attempt static checks. In order to sustain safety (prevent unintended program behavior) these
languages p, they instead perform various dynamic (run-time) checks to make sure that the data structures of
the program stay consistent. Typical runtime checks include

- division-by-zero checks
- array bounds checking,
- verifying that a downcast is valid or not
- **TODO: find what other dynamic checks are usually performed: On the Revival of Dynamic Languages**

When a dynamic check fails, the language runtime produces a runtime error. It depends on the language if a certain
runtim error is recoverable or not: the language may allow the programmer to write error handling code and
resume program execution after the error was handled. [@wiki-type-systems]

> We need to come to terms with persistency, inconsistency and change in pro-
> gramming languages. This means that dynamic programming languages should
> support the notion of software as living, changing systems, they should provide
> support multiple and possibly inconsistent viewpoints of these systems. Static
> type systems still have their place, but they should serve rather than hinder ex-
> pressiveness. [@revival-2005, p. 10]

**TODO: do we need the following? Find a place for them or delete them!**
- overhead of type systems during runtime?
- will it be visible in the complied program?
- how much code does it add?
- does it decrease performance? after all, we are doing more "checks" ???

### Advantages of dynamic languages

**TODO: clean up this sentence: "Some of the following topics are mentioned in [@parmer-type-systems]."**

#### Productivity, faster prototyping

Dynamic languages have rapid edit-compile-test cycles. In the absence of a compiler, these languages favor prototyping and
small scale software development where creating proof-of-concept systems quickly are crucial.

- short term gains, long term losses?

#### Reflection

> Programs lives in files. To change a system, we must edit these files, recompile them, and restart the system [...]
> Surprisingly little effort has been invested over the years in developing languages
> that support run-time change to the persistent program state [@revival-2005, p. 2]

> Reflection enables the changing of systems without the need to rebuild or even restart them. [@revival-2005, p. 6]

Reflection is an umbrella term for programming language features that allow us to inspect and modify a program while it is running.
Most static programming languages provide reflection facilities, but with limited support.

**TODO: write about the advantages of reflection**
...

A totally reflective (dynamic) system with "unscoped" reflection suffers from many disadvantages:

- Security: The clients that use reflection can do anything
- Stability: The effects of reflection are global. One client using reflection affects the other clients
- Performance: Full reflection is costly.

To solve the above issues, the reflective capabilities of the language must be scoped:

- define when and where reflection should be available
- limit the reflective interface to certain clients
- constrain the effects of reflection

[@revival-2005]

#### Flexibility

...

> Dynamic languages are more tolerant to change; code refactors tend to be more localized (they have a smaller area of effect)
> [@hackernoon-s-vs-d]

# A short history of type systems
The first type systems appeared in the 1950s, when the designers of the Fortran language wanted to make
numerical computations more efficient by distinguishing between integer-valued arithmetic expressions
and real-valued ones. This allowed the compiler to generate the appropriate machine instruction making the
program more efficient.
[@pierce-types-and-prog]

> In the late 1950s and early 1960s, this classification was extended to structured data (arrays of records, etc.)
> and higher-order functions. In the 1970s, a number of even richer concepts (parametric polymorphism,
> abstract data types, module systems, and subtyping) were introduced, and type systems emerged as a field in its own right.
> At the same time, computer scientists began to be aware of the connections between the type systems
> found in programming languages and those studied in mathematical logic, leading to a rich interplay
> that continues to the present.
> [@pierce-types-and-prog, p. 10]

**TODO:**

- the different stages of development
- important innovations
- timeline

# Related concepts

In this section I'd like to introduce a few type systems concepts...

...

## Gradual typing
**TODO: just a short mention that such things also exist**

Really good article:
http://wphomes.soic.indiana.edu/jsiek/what-is-gradual-typing/

## Type inference
Type inference is the process of automatically (instead of manually, by the programmer) assigning types
to expressions in a program by examining the operations that are performed on them.

> The first statically typed languages were explicitly typed by necessity.
> However, type inference algorithms - techniques for looking at source code with no type declarations at all,
> and deciding what the types of its variables are - have existed for many years now
> [@debating-type-systems]

**TODO: "not to be confused with dynamic typing! type inference is still static (before execution)!" correct?**

**TODO: pros/cons**

## Polymorphic typing
**TODO: the "distinct identity function" part should go under parametric polymorphism, no? Maybe not!**

A language, where every expression has a single type is called monomorphic. In such a language
there is a distinct identity function of each type: $\lambda \ (x : \tau ) \ x$ even though the
behavior is exactly the same for each choice if $\tau$. Although they all have the same
behavior when executed, each choice requires a different program. [@pfpl-2016]

> [...] motivated by a simple practical problem (how to avoid writing redundant code),
> the concept of polymorphism is central to an impressive variety of seemingly disparate concepts [...]
> [@pfpl-2016 p. 141.]

To facilitate code-reuse, most programming languages feature a polymorphic type system.
A polymorphic languages are those of which the type systems allows different data types to be handled
in a uniform interface. [@ots-2008] Stated more simply: in a polymorphic language, a program fragment
may have multiple types. There are different kinds of polymorphisms, I will look at each of them in
more detail below.

**TODO: find some good parts in this: (Robin Milner, Turing Award winner, paper from 1983)**

https://homepages.inf.ed.ac.uk/wadler/papers/papers-we-love/milner-type-polymorphism.pdf

**TODO: summarize thoughts in this link**

http://www.cs.cornell.edu/info/projects/nuprl/book/node177.html

### Parametric polymorphism - Generics
Sometimes called "compile-time polymorphism", ... **TODO: continue**
- https://docs.oracle.com/javase/tutorial/java/generics/index.html

### Subtyping
Subtype polymorphism is also known as runtime polymorphism.

**TODO: talk about variants of subtyping**

- structural (duck typing) / nominal

### Ad-hoc polymorphism - Typeclasses
**TODO: typeclasses**

- https://en.wikipedia.org/wiki/Polymorphism_(computer_science)
- https://xavierleroy.org/bibrefs/Leroy-unboxed.html
- https://en.wikipedia.org/wiki/Type_system#Polymorphism_and_types

## Abstractions and types
- [Fleury: abstractions](fleury-abs)
- [destroyallsoftware: types](destroyall)
- [types in go](ardanlabs)
- [Abstract types and the dot notation](leroy-dot)

[fleury-abs]: http://ryanfleury.net/blog#a_theoretical_examination_of_the_abstraction
[destroyall]: https://www.destroyallsoftware.com/compendium/types?share_key=baf6b67369843fa2
[ardanlabs]: https://www.ardanlabs.com/blog/2013/07/understanding-type-in-go.html
[leroy-dot]: https://xavierleroy.org/bibrefs/Cardelli-Leroy-dot.html

**TODO: see "Types, abstraction and parametric polymorphism" paper in thesis_papers dir**

**TODO: such a great quote! need to connect it somehow**

> An ADT's user need not know how the object it represents is implemented [...]
> In addition to the intellectual leverage for programmers who can take bigger strides in their thoughts,
> it provides flexibility in modifying the ADT implementation [@tt-oop]

Polymorphism is closely related to the concept of abstraction.
It is the concept of having internally different objects that provide the same interface.
Even though they implement different behaviour, they look the same from the outside and so they can be used
interchangeably. This frees their users (other entities in the program that use them) from having to differentiate
between them and allows them to ... **TODO: finish note**

## Type systems and software security
**TODO: google "type systems and security"**

- defensive mechanisms provided by type systems
    - look at the most common sources of vulnerabilities, see if type systems could help
        - need data!
- solving injection with a type system
    - http://blog.moertel.com/posts/2006-10-18-a-type-based-solution-to-the-strings-problem.html

**TODO: summarize CAR Hoare's presentation on `NullPointerException`s (The Billion Dollar Mistake - 2009)**

- https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare
- 31:10 great notes about what to expect from programming languages
- 31:40 "formal verification"
- 37:34 "now, the real commercial imperative which requires greater attention paid to formal correctness of the programs is the virus."
    - "it reaches paths of your program that normal execution never reaches"
    - "it's no longer adequate to test your program against all the cases that are likely to arise..."
- 50:00 great thoughts about the `jmp` machine instruction

## Run-time type information

...

> Another operation that relies heavily on run-time type information is marshaling and un-marshaling between
> arbitrary data structures and streams of bytes – a crucial mechanism for persistence and distributed programming.
> [@leroy-intro-tic98 p. 5] 


# Own research: surveying a selected list of programming languages 

**TODO: short intro, why the chosen languages**

**TODO:find what methods are used for comparing type systems**

In the following, I'm going to introduce the type systems of an exotic assortment of languages. The languages were selected so that
each one features a different concept or idea with regards to type systems.

...

Implementing the same program in all these languages with the intent of comparing them would make little sense as they all
serve different purposes.

**TODO: based on what? need some qualitative approach! how and what to compare?**

## Structure, methods of analysis
For each language I'll try to highlight one or two key type systems features and examine how those affect writing programs in the language.

... 

### Assembly
 
**TODO: Explain why assembly has no types! Are there any advantages of not having types?**


...

### Javascript

Javascript is a dynamic language, often referred to as a "weakly typed" (or unsafe) one because it makes many implicit type conversions
during runtime. Javascript is one of the most popular languages of the 2010s mainly because it is the scripting language of
web browsers.

#### Static / strong variants

Javascript's wild popularity and ubiquitousness prompted organizations to invest in creating a static type system for the language.
The most popular staticly typed variants of the language are:

- TypeScript (Microsoft)
- Closure (Google)
- Flow (Facebook)

**TODO: why add a static type system?**

**TODO: read through [@type-or-not-js]**

[@type-or-not-js]

### Python

Python features a dynamic type system. it is usually called a "strongly typed" (or safe) language because even
though its type system doesn't enforce strict typing rules at compile type it is very strict about what operations
are allowed on what types during runtime and it will not do automatic type conversions that could go unnoticed.

...

### C / C++

...

**TODO: talk about what safety features are added by C++ (references, what else?)**

### Java

Java is a staticly typed, safe language. It features a static type system enhanced with various dynamic checks.

...

#### Type erasure

**TODO: https://en.wikipedia.org/wiki/Generics_in_Java#Problems_with_type_erasure**

...

#### Other JVM-based languages

There are other languages, some quite popular that also use the JVM runtime but are wildly different from Java with
regards to their type systems.

- Groovy
- Scala

### Clojure (LISP family)

**TODO: look up some articles/papers on Clojure's type system and dynamic model**

- also JVM based
- dynamic
- talk about some interesting features of LISPs

...

### GO

Developed by progamming language veterans at Google, GO features an interesting combination of stong static typing,
first class support for concurrency ...

**TODO: talk about channel types**

...

### OCaml, Haskell (any ML language)

The ML family of languages are the prominent representatives of the functional paradigm.

**TODO: Hindley-Milner - https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system**

...

#### Algebraic data types
Algebraic data types are composite types: they are defined as a combination of other types.
In most imperative languages conditional expressions (if-else statements) can define any number of branches
that are not checked for consistency. Execution enters these branches based solely on their predicates,
boolean valued "functions". This means that by mistake, they can overlap or fail to handle all possible cases.
In functional languages, with the help of pattern matching algebraic data types facilitate a type safe
implementation of conditional expressions. They let us define the branching logic in terms 
of a composite type and allow the type system to check whether we we covered all the cases. [@parmer-type-systems]

**TODO**:

- Sum types
    - Maybe / Option
        - note: "nullable" in dynamic languages where ther is NULL, "option" or "maybe" in static languages
        - Null pointer exceptions vs. "Maybe" types
    - Try
- Product types
- https://en.wikipedia.org/wiki/Algebraic_data_type

### Agda

Agda might be an outlier in this list, but I definitely wanted to include it and talk about its facilities.
It is a "proof assistant" that can also be used for general purpose programming.

**TODO: http://learnyouanagda.liamoc.net/pages/introduction.html**

...

### Rust

Rust is a fairly young language that is rapidly gaining popularity. It aims to provide a replacement to low level,
high-performance but unsafe languages like C and C++ by promising both memory safety and highly optimal machine code.

- ownership, borrows
- immutability
- etc

**TODO: nice paper: https://sergio.bz/docs/rusty-types-2016.pdf**

...

## Conclusions

...

# References
