---
title: "A survey of type systems in programming languages"
subtitle: "Óbudai Egyetem - Neumann János Informatikai Kar, mérnökinformatikus szak"
author: "András Sallai"
date: "2019"
keywords: [Type systems, Programming languages]
...
\pagenumbering{gobble}
\pagebreak

\tableofcontents

\pagebreak
\pagenumbering{arabic} 

# Introduction, personal motivation
The first languages I worked with were dynamic scripting languages. Software development
was a process of trial-and-error with the error part happening only when I ran my programs. 
When I first started using statically typed languages it was more difficult but also much more rewarading.
The static type system helped write code more effectively and more confidently.
It forced me to think more thoroughly, it gave me confidence when changing parts of the program.
It was much more pleasant to write software like this.
I became more and more interested in the possibilities of static checking and type systems.
I started wondering what features can programming languages provide to increase
programmer productivity and software quality.
This curiosity led me to choosing type systems as the topic of this work.

My goal with this thesis is to gain a more fundamental understanding of the semantics of programming languages,
the structures and algorithms behind them.
First, I'll survey the history and theoretical background of type systems.
I'll look at how type systems evolved, and how they can be categorized.
**TODO: revise:**
I'll compare the type systems of widely used programming languages and will try to
give an overview of the possibilities of recent advances in type systems and programming language design.

# Hypotheses
1. Untyped languages are inferior to typed ones. **Why are types missing from assemblers?**
2. Static type checking can measurably increase programmer productivity. **Likely false, there seems to be no evidence**
3. 

\pagebreak

# Part 1: Type systems - review of literature
> Modern software engineering recognizes a broad range of formal methods for helping ensure that a system behaves correctly [...]
> by far the most popular and best established lightweight formal methods are type systems.
> [@tapl, p. 1]

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
A program that violates the rules of its type system is often called "ill typed". A program that conforms
to those rules is a "well typed" program. [@wiki-type-systems]

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
in order to resolve contradictions present in his set theory. Type theories (there are many,
like Alonzo Church's Simply Typed Lambda calculus or Per Martin-Löf's Intuitionistic Type Theory)
are formal systems which means they define rules for inferring theorems (statements) from axioms.
[@stanford-tt]

> Type theory is a formal language, essentially a set of rules for rewriting certain strings of
> symbols, that describes the introduction of types and their terms, and computations with these, in a sensible way.
> [@ncatlab-tt]

Type theory lays down the theoretical foudation for the type systems found in programming languages and
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

## A short history of type systems
The first type systems appeared in the 1950s, when the designers of the Fortran language wanted to make
numerical computations more efficient by distinguishing between integer-valued arithmetic expressions
and real-valued ones. This allowed the compiler to generate the appropriate machine instruction making the
program more efficient.
[@tapl], [@tt-oop]

> In the late 1950s and early 1960s, this classification was extended to structured data (arrays of records, etc.)
> and higher-order functions. In the 1970s, a number of even richer concepts (parametric polymorphism,
> abstract data types, module systems, and subtyping) were introduced, and type systems emerged as a field in its own right.
> At the same time, computer scientists began to be aware of the connections between the type systems
> found in programming languages and those studied in mathematical logic, leading to a rich interplay
> that continues to the present.
> [@tapl, p. 10]

**TODO:**

- the different stages of development
- important innovations
- timeline

# Type checking

Type checking is the process of deciding whether a term is well typed or not.
A type checker verifies that the constraints posed by the type system are not violated
by the program. Type checking can be done by automated tools called typecheckers, which are usually
built into compilers or linkers. [@debating-type-systems]

There are two main branches of languages with regards to type checking (or "typing"): static and dynamic.
Statically typed languages carry out type checking before the program is actually run.
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
happen at runtime. I'll discuss each approach separately in a later section.

## Type checking algorithms

There are various approaches to type checking but the general idea behind the algorithms is the following:

1. Parse the source code into an "Abstract Syntax Tree" (AST)
2. Annotate each node in the AST with a "type annotation"
3. Generate constraints: enumerate all the known relations between the types of the nodes.
4. Use constraint solving to see if the constraints can be satisfied.

In the next section I'll give a brief overview of static and dynamic languages highlighting the differences and will later go into much more
detail when surveying my selected list of programming languages.

**TODO: https://danluu.com/empirical-pl/**
	- A Large-Scale Study of Programming Languages and Code Quality in GitHub
		- see what they mean by "strong/weak typing"
	- 0install: Replacing Python; Leonard, T., pt2, pt3
	- The Unreasonable Effectiveness of Dynamic Typing for Practical Programs
	- Do Developers Benefit from Generic Types?
		- https://scihub.wikicn.top/10.1145/2509136.2509528

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

**TODO: summarize https://vimeo.com/74354480 - Not my favourite talk, but has good points**

#### Quick results
Dynamic languages have rapid edit-compile-test cycles. In the absence of a pre-runtime type checking phase, these languages favor prototyping and
agile software development where creating proof-of-concept systems quickly are crucial.
**TODO: more**

#### Reflection
> Programs lives in files. To change a system, we must edit these files, recompile them, and restart the system [...]
> Surprisingly little effort has been invested over the years in developing languages
> that support run-time change to the persistent program state [@revival-2005, p. 2]

Reflection is an umbrella term for programming language features that allow us to inspect and modify a program while it is running.
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

#### Flexibility

A dynamic type system can help write more modular and decoupled code which may lead to a more flexible design.
Module boundaries (the types, structures, interfaces that each module expects to see from another one) are not fixed down
so it becomes possible to "plug in" other modules that may provide the required set of constructs without having to
match them together. Modifying modules to meet interface requirements of other modules can be done incrementally.

> Dynamic languages are more tolerant to change; code refactors tend to be more localized (they have a smaller area of effect)
> [@hackernoon-s-vs-d]

**TODO: consult Rich Hickey for advantages of dynamic languages**

## Language/type safety

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

People often conflate static typing, dynamic typing and type safety. Regardless of whether type checking happens
statically (before running the program) or dynamically (during running the program), a language may or may not be called safe,
we'll see examples later when discussing the type systems of specific languages.
"Strongly typed" and "weakly typed" are also in wide use among programmers but their meaning is not clearly defined and are
often used to mean certain combinations of language attributes. They are often used to refer to how much implicit conversion
(also known as "coercion") between types is done by the language.

There might be operations that would pass type checking but produce an error during runtime, like division by zero.
Enhancing a type system so that it could protect against division by zero erros would make it too restrictive
(too many programs would be ruled out as ill-formed).
It is not possible to predict statically that an expression would evaluate to zero,
so if we want our language to be safe, we need to add dynamic (runtime) checks. Even though it is not part
of the static type system, such a language is still considered safe. [@pfpl-2016]

### Formal soundness: preservation and progress
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

# Related concepts

In this section I'd like to introduce a few type systems concepts...

**TODO: "existential types", "universal types"?**
https://stackoverflow.com/a/5520212/1772429

...

## Gradual typing
**TODO: just a short mention that such things also exist**

Really good article:
http://wphomes.soic.indiana.edu/jsiek/what-is-gradual-typing/

## Type reconstruction
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

## Polymorphic typing - polymorphism
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

Polymorphism is the concept of having internally different objects that provide the same interface.
Even though they implement different behaviour, they look the same from the outside and so they can be used
interchangeably. This frees their users (other entities in the program that use them) from having to differentiate
between them and allows them to ... **TODO: finish note**

**TODO: find some good parts in this: (Robin Milner, Turing Award winner, paper from 1983)**

https://homepages.inf.ed.ac.uk/wadler/papers/papers-we-love/milner-type-polymorphism.pdf

**TODO: summarize thoughts in this link**

http://www.cs.cornell.edu/info/projects/nuprl/book/node177.html

### Ad-hoc polymorphism - Interfaces
Ad-hoc polymorphism is when we can define a common interface for an arbitrary set of individually specified types.
The typical example are interfaces in most OOP languages. The types that implement the interface may not otherwise be related.
[@wiki-polymorphism]

- https://en.wikipedia.org/wiki/Polymorphism_(computer_science)
- https://xavierleroy.org/bibrefs/Leroy-unboxed.html
- https://en.wikipedia.org/wiki/Type_system#Polymorphism_and_types

#### Structural vs Nominal typing
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

### Subtype polymorphism - Subtyping
Subtype polymorphism or runtime polymorphism is the process of taking a type (the base type)
and defining a more specialised type (the subtype) based on it by extending it with functionality or
overriding some parts to facilitate code reuse.
The subtype is related to the supertype by the notion of substitutability which means that in a program the subtype
can be used wherever the supertype is expected. Subtyping is related to but should not be confused with inheritance.
[@wiki-subtyping]

### Parametric polymorphism - Generics
Sometimes called "compile-time polymorphism", ... **TODO: continue**
- https://docs.oracle.com/javase/tutorial/java/generics/index.html

#### Variance

- invariance
- covariance
- contravariance

**TODO: read these:**
https://blog.daftcode.pl/csi-python-type-system-episode-1-1c2ee1f8047c
https://blog.daftcode.pl/csi-python-type-system-episode-2-baf5168038c0
https://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)
https://en.wikipedia.org/wiki/Covariant_return_type

## Concrete vs abstract types

Most programming languages differentiate between concrete and abstract types.
A concrete type corresponds to the concept of a "data structure", a collection of data values and the relationships between them.
A concrete type in a programming language precisely defines the memory layout of the data that objects of that type hold.

**TODO: some more info on concrete types**

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
- **TODO: what else?**

Abstract types are related to but should not be confused with the general concept of "abstraction".

## Abstraction and types

Abstraction is the principle of reducing something to its essential characteristics, removing everything that is unnecessary
to accurately represent it for a particular usage. Abstraction reduces complexity and increases efficiency. [@whatis-abstraction]

- [Fleury: abstractions](fleury-abs)
- [destroyallsoftware: types](destroyall)
- [types in go](ardanlabs)
- [Abstract types and the dot notation](leroy-dot)

[fleury-abs]: http://ryanfleury.net/blog#a_theoretical_examination_of_the_abstraction
[destroyall]: https://www.destroyallsoftware.com/compendium/types?share_key=baf6b67369843fa2
[ardanlabs]: https://www.ardanlabs.com/blog/2013/07/understanding-type-in-go.html
[leroy-dot]: https://xavierleroy.org/bibrefs/Cardelli-Leroy-dot.html

**TODO: see "Types, abstraction and parametric polymorphism" paper in thesis_papers dir**

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

> Many programming languages require compiled programs to manipulate some amount
> of type information at run-time [@leroy-intro-tic98 p. 4] 

...

> Another operation that relies heavily on run-time type information is marshaling and un-marshaling between
> arbitrary data structures and streams of bytes – a crucial mechanism for persistence and distributed programming.
> [@leroy-intro-tic98 p. 5] 


# Part 2: Own research - type systems in programming languages

**TODO: ezeket vizsgálni a nyelveknél:**
```
- hogyan jelennek meg a típusok a nyelvben? milyen nyelvi elem(ek) által?
- milyen kapcsolatokat képes a nyelv modellezni a típusok között? mit jelentenek ezek?
    - Elm tanulás közben jutott eszembe. Ott a típusok "üresnek tűnnek" (egyszerű "type" definíciókban csak neveket adunk meg, metódusok/függvények nem részei a típusdefiníciónak), és mégis sokrétűen lehet őket használni (generikusság, paraméterek)
```

**TODO: short intro, why the chosen languages**

**TODO:find what methods are used for comparing type systems**

In the following, I'm going to examine list of programming languages.
My goal is to introduce a wide range of type systems concepts with concrete examples.

The languages:

- Assembly
- JavaScript
- Python
- C/C++
- Java
- Clojure `*`
- Go
- ML languages (Ocaml, Haskell, Elm)
- Agda / Idris/ Coq `*`
- Rust `*`

The languages were selected based on my interests and so that each one features a different
concept or idea with regards to type systems. My original goal with this thesis was to gain a deeper understanding
of programming language concepts and try out some languages that I've been interested in for a long time.
Items marked with an asterix (\*) are languages with which I had no prior experience.
I'll focus on their type systems based on material I could find as well as my own experiences.

...

Implementing the same program in all these languages with the intent of comparing them would make little sense as they all
serve different purposes.

**TODO: based on what? need some qualitative approach! how and what to compare?**

...

## Structure, method of analysis
For each language I'll try to highlight one or two key type systems features and examine how those affect
writing programs in the language.

... 

### Assembly
> [assembly language] is any low-level programming language in which there is a very strong correspondence
> between the instructions in the language and the architecture's machine code instructions.

**TODO: finish video**: https://vimeo.com/74354480
	- 12:15

Assembly languages are - barring some academic derivatives - untyped. The values that we can manipulate in the language
are just byte sequences. There is no way of knowing what a register or memory address holds just by looking at the assembly code.
A given bit pattern may have multiple valid interpretations as different types. A certain system call might expect an 8 byte integer
value for printing, but an 8byte floating-point value can also be interpreted as an integer.
Assemblers don't try to check for matching types. Why has this
**TODO: Why is that?**

**TODO: Explain why assembly has no types! Are there any advantages of not having types?**

**TODO: look into untyped languages, summarize them here!**

Typed Assembly Language papers (from around 1999)
http://www.cs.cornell.edu/talc/papers.html

...

### JavaScript and static variants

**TODO: safety?**
	- https://stackoverflow.com/a/25157350/1772429
	- https://stackoverflow.com/a/39642986/1772429

JavaScript is one of the most popular languages of the 2010s mainly
because it is the scripting language of web browsers which, thanks to their ubiquitousness, are becoming
the platform of choice for user-facing networked applications. JavaScript is a dynamically typed language.
Types of program variables are not known before run time.
The language is often referred to as a "weakly typed" one because the runtime makes many
implicit type conversions between types. The conversion rules are often inconsistent but are strictly 
specified. Because of these inconsistencies, people often refer to JavaScript as not being "type safe" in a loose meaning
of the term.

**TODO: more on dynamic type system features**

JavaScript's popularity and ubiquitousness prompted organizations to invest in creating a statically checked variants of the language.

#### TypeScript (Microsoft)
Typescript extends the JavaScript language with optional type annotations and provides a typechecker and transpiler
for JavaScript programs. Thanks to its type inference, every valid JavaScript program is also a valid TypeScript program
so it is possible to gradually transform a JavaScript codebase into a TypeScript one.

Optional typing means the programmer can choose to make use of the type checker or not. Type annotated parts of the
code will be typecheked, the other parts will not.
In my experience, this tends to make the programmer more lazy. Omitting type annotations can help finish writing a certain part
of the program faster. The program might even run without error when tested. The problem is that we likely didn't cover all the
possible execution paths and by "shutting down" the typechecker we made it harder to find the possible inconsistencies in the code.
The program seems to behave correctly but had we defined types properly, we could have been warned about type errors
that will now show themselves later at an unexpected time.

**TODO:**
- https://blog.ambrosebs.com/2018/04/07/unsoundness-in-untyped-types.html
	- https://users.soe.ucsc.edu/~abadi/Papers/FTS-submitted.pdf (from the above, this is the important one!)
- https://www.typescriptlang.org/docs/handbook/type-compatibility.html
	- look for "unsound" keyword!

**TODO: nice notes about its typesystem: https://www.typescriptlang.org/docs/handbook/intro.html#get-started**

#### Closure Compiler (Google)
Google's Closure Compiler is a static code analyzer and transpiler (compiles to a specific form of the same language).
It includes a type checker that can read specifically formatted comment sections  -JsDoc- [@jsdoc] which
contain typing information.

#### Flow (Facebook) https://flow.org/en/docs/lang/

**TODO: why add a static type system?**

**TODO: read through [@type-or-not-js]**

[@type-or-not-js]

### Python

Python features a dynamic type system. It is usually called a "strongly typed" language because even
though its type system doesn't enforce strict typing rules at compile type it is strict about what operations
are allowed on what types during run time and it will rarely do automatic type conversions.

#### Optional type annotations in Python 3

Even though Python 3 is dynamically typed, the language allows optional "type hints" which are similar to
type declarations in languages like Java. These annotations may be used together with type checkers like `mypy`,
`pyre-check` or `pytype` [@py-type]. The programmer is free to annotate only parts of the source code.
The Python 3 runtime itself doesn't typecheck the type hints. Thanks to python's dynamic nature,
the following code will be executed without any errors in Python 3.5.2:

~~~{.python}
def f(a: int, b: int) -> str:
    return a + b

print(f("x", "y"))
print(f(1, 2))
~~~

The programmer has to use one of the external type checkers to make use of type hints. Running `mypy`
on the above code indeed reports type errors complaining about an incompatible return type declaration and incompatible
argument types when calling the the function with integer values.

The language is radically dynamic. Python's variables are just names that are bound to objects. They can be rebound any time during
execution and they always take on the type of the bound object, thus potentially changing their type.
This dynamic, loose type system is critical in Python's reputation as a language of quick, agile
software development and prototyping. 

The central element of its type system is the class. Python classes work the same way as they do in other classical OOP languages but
they - and their instances - are extremely dynamic.
Member variables and methods can be added to instances of classes after they have been instantiated. They can also be modified
or deleted altogether. Objects can change class, classes can change base classes.
The excessive dynamism of the language makes it hard to do static analysis and early error detection on python code. [@dynamic-python]

### C

- procedural, not OOP!
- lots of missing type system features
- what does C have in place of all the OOP concepts?
	- interfaces?
	- inheritance?
	- polymorphism?

**TODO: talk about how huge, important and popular software projects are still written in C (Linux kernel!) despite the lack of OOP support**

**TODO: unsafe!**
- "unchecked casting" - **TODO: correct term?**
- pointers, pointer arithmetic - **TODO: eplain why unsafe!**
- https://stackoverflow.com/a/25157350/1772429
- https://stackoverflow.com/a/969095/1772429
	- see part about conversion being dynamically checked
		- `instead of treating the bytes of the array object as if they were a FileStream`

Union types
`untagged unions`: https://golang.org/doc/faq#unions

### C++

Examining C++ after C is a good way of demonstrating ...

TODO: list major type system features that C++ adds to C
- classes, (abstract classes as interfaces)
- polymorphism
	- inheritance is not really a type system feature, is it?
- templates (generics)
- multiple inheritance
	- does this fit into type systems?

**TODO: talk about what safety features are added by C++ (are references safety features? why? what else?)**

RedHat article about static analysis: adding -fanalyze flag to GCC
https://developers.redhat.com/blog/2020/03/26/static-analysis-in-gcc-10/

Virtual functions/methods & dynamic dispatch
- **TODO: also applies to Java on this list**
> In object-oriented programming, in languages such as C++, and Object Pascal, a virtual function or virtual method is an inheritable and overridable function or method for which dynamic dispatch is facilitated. This concept is an important part of the (runtime) polymorphism portion of object-oriented programming (OOP). In short, a virtual function defines a target function to be executed, but the target might not be known at compile time.
> https://en.wikipedia.org/wiki/Virtual_function

Really good article on static/dynamic dispatch:
https://medium.com/ingeniouslysimple/static-and-dynamic-dispatch-324d3dc890a3

Dynamic binding and polymorphism
https://rcweb.dartmouth.edu/doc/ibmcxx/en_US/doc/language/concepts/cndbpoly.htm

### Java

Java is a statically typed, "safe" language. **TODO: why safe?**
	- `not?`: https://www.cis.upenn.edu/~bcpierce/courses/629/papers/Saraswat-javabug.html

It is a "mandatory OOP" language, meaning that the class is the basic unit of code organization, and also the basic
container of all data and behavior at runtime.
[@typescript-docs]

It features a static type system enhanced with various dynamic checks provided by its runtime
environment, the Java Virtual Machine (JVM).

Fundamentals of java generics
http://www.angelikalanger.com/GenericsFAQ/FAQSections/Fundamentals.html
	- link from the above: http://www.angelikalanger.com/GenericsFAQ/FAQSections/TechnicalDetails.html#Why%20does%20the%20compiler%20add%20casts%20when%20it%20translates%20generics?

Unified type system (maybe only for C#?): https://en.wikipedia.org/wiki/Comparison_of_C_Sharp_and_Java#Unified_type_system

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
- talk about some interesting TYPE SYSTEM features of LISPs

Lisp type system: https://lispcookbook.github.io/cl-cookbook/type.html

### GO

Developed by progamming language veterans at Google, GO features an interesting combination of stong static typing,
first class support for concurrency and an object oriented style built around composition.

**TODO: https://thenewstack.io/understanding-golang-type-system/**

- there is no inheritance as in classical OOP! instead there is composition
- inheritance vs composition
	- https://stackoverflow.com/questions/49002/prefer-composition-over-inheritance
		- composition: changing behavior is possible at runtime (?)
	- https://www.javaworld.com/article/3409071/java-challenger-7-debugging-java-inheritance.html
- difficult at first because most of us is trained to think in a classical OOP way
- **TODO: benefits of Go's non-classical OOP model ?**

Go is a good example of how subtyping is a different concept from inheritance.
Structs (a collection of related attributes) with methods resemble classes of classical OOP languages but in Go there is no subtype polymorphism
(or any kind of polymorphism) for stucts. Struct types can embed other stuct types where the embedder type
gains access to the methods of the embedded type. This provides a limited form of inheritance. The embedder
type however doesn't become a subtype of the embedded one. Most programmers are trained to think in a classical
object oriented way where derived classes not just inherit from, but also become subtypes of their parents.
I also come from such a backgroud and in my experience, learning the basics of Go and using it in a procedural style
is simple. Once we had to write more complex type relationships and resort to the language's object oriented features,
it became much harder and I was stuck for a good while trying to understand how my familiar object hierarchies
can be expressed with this language.

> In Go the line between inheritance and composition is pretty blurry [...]
> Syntactically, inheritance looks almost identical to composition.
> [@oo-inheritance-in-go]

**TODO: continue with own experience, especially after understanding the Go way of OOP**

Go's interfaces provide ad-hoc polymorphism and are a form of sturctural subtyping.

> interfaces—these are fundamental to Go’s approach to **type-safe duck typing**
> [@summerfield-go, p. 254.]

To make use of polymorphism, we define interfaces. Interfaces are nothing more than a set of function signatures.
To make use of interfaces, we define _methods_. Methods are functions defined on a specific type.
An interface is automatically implemented by a type if it has all the methods required by the interface. 

> [...] relationship between concrete types and abstract types (interfaces) is implicit, so a
> concrete type may satisfy an interface that the type’s designer was unaware of.
> [@gopl, p. XV]

**TODO: Unsafe package:**
> Chapter 13 explains the gory details of low-level programming that uses the unsafe
> package to step around Go’s type system, and when that is appropriate.

#### Channels - **TODO: revise later!**
Go's type system extends to its concurrency model. The language has first class suppor (meaning syntactic elements)
for manipulating _channels_. Channels are typed conduits through which we can send and receive values.

#### Type assertions vs type conversions

https://tour.golang.org/methods/15
https://stackoverflow.com/a/20494572/1772429
https://groups.google.com/d/msg/golang-nuts/dwSPKq9YDso/xJMn4qgttGoJ

### ML family - OCaml, Haskell, F#, Elm

The ML family of languages are the prominent representatives of the functional paradigm.
**TODO: 1-2 sentence about "functional"**

**TODO: Hindley-Milner - https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system**

**TODO: no exceptions seem to be needed in these languages. true? why?**

from [@abrahamson-quora]

- sum types,
- purity,
- effect types,
- quantified/generic types,
- quantified modules,
- region types,
- linear types,
- anonymous record types,
- polymorphic variant types

**TODO: Ad-hoc polymorphism and Type classes**
ad-hoc: https://stackoverflow.com/a/42417159/1772429

#### Elm
**Elm's type system: https://elmprogramming.com/type-system.html**
**TODO: get inspired by Elm custom types: https://guide.elm-lang.org/types/custom_types.html**

**TODO: write about MY experience with every other language!**

#### My Elm experience
As a beginner Elm user, programming in the language feels very much like a fight, or rather an argument with the typechecker.
"I want this done here. No you can't do that, unless you do it that way there, there and there."
Everywhere the types need to match and even the slightest change can trigger an avalanche of type errors.
This can be a source of much frustration but as tiresome it may seem, the resulting software is remarkably bug free.
This is because the type system creates a solid underlying structure to the program.
At first sight the language seems hostile to the programmer, but as our code grows in complexity, the warnings of the type checker
become more and more valuable. We are not doing more work, we just do more of the work _before_ we ship our software.

Types in elm feel extremely lightweight. They are almost just labels on the underlying data. **TODO: revise, expand!**
https://medium.com/elm-shorts/an-intro-to-constructors-in-elm-57af7a72b11e

https://elmprogramming.com/type-system.html

- the compiler feels like a co-pilot that is constantly helping
	- it almost feels like pair programming
- it is the type system that makes it possible for the compiler to produce such helpful messages!

```
Ezen pedig gondolkodni, kifejteni:

type Result error value
    = Ok value
    | Err error

Itt error és value mintha típus paraméterek lennének, de úgy tudom, állhatna ott konkrét típus (vagy talán még value is?). Mikor mi? Mi a különbség az egyes esetek között? Ha ez a generikusság megfelelője Elm-ben, akkor ki kéne fejteni, hogy pl C#-ban hogy volt ez. Ott lehet mixelni típus paraméterrel konkrét típusokat?
```

https://package.elm-lang.org/packages/elm-lang/core/5.1.1/Json-Decode#map
> Note: If you run out of map functions, take a look at elm-decode-pipeline which makes it easier
to handle large objects, but produces lower quality type errors.

#### Algebraic data types
Algebraic data types are composite types: they are defined as a combination of other types.
In most imperative languages conditional expressions (if-else statements) can define any number of branches
that are not checked for consistency. Execution enters these branches based solely on their predicates,
boolean valued "functions". This means that by mistake, they can overlap or fail to handle all possible cases.
In functional languages, with the help of pattern matching, algebraic data types facilitate a type safe
implementation of conditional expressions. They let us define the branching logic in terms 
of a composite type and allow the type system to check whether we we covered all the cases. [@parmer-type-systems]

**TODO**:

- Sum types
    - Maybe / Option
        - note: "nullable" in dynamic languages where ther is NULL, "option" or "maybe" in static languages
        - Null pointer exceptions vs. "Maybe" types
            - https://guide.elm-lang.org/error_handling/maybe.html
    - Try
- Product types
- https://en.wikipedia.org/wiki/Algebraic_data_type

**TODO: https://stackoverflow.com/a/10510934/1772429 - what does this mean?**
> Algebraic data types allows sums as well as products, whereas OO-style classes only allow products.

### Agda / Idris / Coq

**TODO: take a look at them, decide which one to focus on**

Agda might be an outlier in this list, but I definitely wanted to include it and talk about its facilities.
It is a "proof assistant" that can also be used for general purpose programming.

> The most advanced type systems available today — those available for languages such as Agda and Coq and Idris —
> are truly interactive. Programming in one of those languages is like a conversation with the type-checker
> where you express your intent and your attempt and the checker asks you questions to see whether those two
> match up the way they ought to. And then you interactively repeat this process to build your program. [@abrahamson-quora]

**TODO: http://learnyouanagda.liamoc.net/pages/introduction.html**

- inductive types
- total functions

type driven development in Idris:
https://codesync.global/media/idris-2-type-driven-development-idris-edwin-brady/

#### Dependent types
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

...

### Rust

https://www.youtube.com/watch?v=2wZ1pCpJUIM
- rust part begins at `25:05`
- algebraic data types `29:40`
	- **Algebraic types allow robust, concise error handling** - what does this mean? why?
- 

Rust is a fairly young language that is rapidly gaining popularity. It aims to provide an alternative to low level,
high-performance but unsafe languages like C and C++ by promising both memory safety and highly optimal machine code.

**TODO about the above quote:**
- what is memory safety?
- how does one language generate more optimal machine code than the other?

- ownership, borrows - **TODO: this is exciting type systems material!**
	-ownership: a novel system whereby it can statically determine when a memory object is no longer in use
- immutability
- etc

**TODO: nice paper: https://sergio.bz/docs/rusty-types-2016.pdf**

https://github.com/doctorn/micro-mitten
> "Like Rust, micro-mitten offers a static approach to memory management"

...

## Summary
In my own experience, a statically typed language is clearly a better tool for writing good, working software.
I am surprised at the lack of evidence that can back this claim. **TODO: revise!**

Dynamic languages offer a low barrier to entry and apparent agility that provides quick results with short development times.
Many originally dynamic languages (javascript, python, ruby, php) however added support for some form of optional typing later in their
development. **TODO: revise!**

...

# References
