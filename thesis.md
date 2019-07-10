---
title: "Examination of the evolution of type systems in programming languages"
subtitle: "Óbudai Egyetem - Neumann János Informatikai Kar, mérnökinformatikus szak"
author: "András Sallai"
date: "2019"
keywords: [Type systems, Programming languages]
...

\pagebreak
\tableofcontents
\pagebreak

**Megjegyzés a tisztelt bíráló bizottságnak**: A dolgozatom jelen állapota egy köztes állapot,
több helyen tartalmaz feljegyzéseket, jelöléseket a további munkához.
A terület, amit választottam nagyobb, érdekesebb, mint először gondoltam,
jóval több tájékozódást és munkát igényel a részemről, mint számítottam, viszont
szándékomban áll mélységében áttekinteni és a hiányzó részeket kidolgozni.
A hiányzó fejezeteket a következő időszakban illetve a Szakdolgozat II. tágy keretein belül fogom
befejezni.

\pagebreak

# Introduction, personal motivation
After having worked with dynamic languages for a few years, when I first started using C#
I was struck by how much its static type system and typechecker helped me write code faster and more confidently.
The type system made me think more thoroughly, it allowed me to change parts
of the program and be confident that I didn't break it.
It was a different way of writing software than I had done before.
I became more and more interested in the possibilities of static checking and type systems.
I started wondering what else was out there that could increase programmer productivity
and software quality. This curiosity led me to choosing type systems as the topic of my thesis.

My goal with this thesis is to gain a more fundamental understanding of programming languages,
the structures and algorithms behind them.
First, I'll survey the history and theoretical background of type systems.
I'll look at how type systems evolved, and how they can be categorized.
I'll compare the type systems of widely used programming languages and will try to
give an overview of the possibilities of recent advances in type systems and programming language design.

# Type systems
> Modern software engineering recognizes a broad range of formal methods for helping ensure that a system behaves correctly [...]
> by far the most popular and best established lightweight formal methods are type systems.
> [@pierce-types-and-prog, p. 1]

A type system is a set of rules that associate a property called a **type** to various constructs in a computer program.
A type defines a range of values as well as possible operations on instances of that type.
The main purpose of type systems is to reduce possibilities for bugs in computer programs.
The type system associates a type with each value in the program and then by examining the flow of these values
attempts to prove that no operation violates them.

Such a violation is called a **type error**. It is an inconsistency in a program according to the type system's rules.
Exactly what constitutes a type error is defined by the type system of the language.
A program that violates the rules of its type system is often called ill typed. A program that conforms
to the rules of the language's type system is a well typed program.

[@wiki-type-systems]

> Type systems are used to determine whether programs are well behaved [...].
> Only program sources that comply with a type system should be considered real programs of a typed language;
> the other sources should be discarded before they are run.
>
> [@cardelli-96, p. 2]

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
>
> [@cardelli-96, p. 3]

By using the facilities provided by the type system, we can add more information in our programs.
W can create a safety-net against execution errors by making it possible for automated tools to verify the steps
we take throughout our code.
Through types, we can add more meaning, a deeper, more solid structure. That structure aids
us when we later change parts of the program or add new components to it.

Type systems are the glue between mathematical logic and computer programs. They make it possible to
prove that our programs behave correctly. Advanced, sophisticated type systems allow us to express
a finer, more precise structure and thus more properties of our sofware may be proven by automated tools.

**TODO: add note on why this should motivate type system research; benefits for working programmers**

**TODO: add more notes after having worked with Haskell/OCaml**

## Type theory
Type theory is a branch of mathematical symbolic logic: a system of representing logical expressions
through the use of symbols. It was concieved in the beginning of the 20th century by Bertrand Russell
in order to resolve contradictions present in his set theory. Type theories (there are many,
like Alonzo Church's Simply Typed Lambda calculus or Per Martin-Löf's Intuitionistic Type Theory)
are formal systems which means they define rules for inferring theorems (statements) from axioms.

[@stanford-tt]

> Explicitly, type theory is a formal language, essentially a set of rules for rewriting certain strings of
> symbols, that describes the introduction of types and their terms, and computations with these, in a sensible way.
>
> [@ncatlab-tt]

Type theory lays down the theoretical foudation for the type systems found in programming languages and
the typechecking algorithms behind them.

**TODO: https://github.com/jozefg/learn-tt**

## Language safety

> [...] a safe language is one that protects its own abstractions [...]
> Every high-level language provides abstractions of machine services. Safety refers to the language’s
> ability to guarantee the integrity of these abstractions and of higher-level abstractions
> introduced by the programmer using the definitional facilities of the language.
>
> [@pierce-types-and-prog, p. 6]

As [@pierce-types-and-prog] puts it, the abstraction of a safe language can be used "abstractly", whereas in an unsafe language
it is necessary to keep in mind the low level details, like how data is structured in memory or how allocations take place
in order to understand how the program might misbehave.

Note that "language safety" can be achieved by static type checking but also by run-time checks, like array-bounds checking is
performed by many languages during runtime.

[@types-primer] says that a programming language or language construct is type-safe if it forbids
operations that are incorrect for the types on which they operate. The author notes that some languages
may discourage incorrect operations or make them difficult without completely forbidding them so
we may compare the level of type safety offered by two programming languages.

[@cardelli-96] differentiates between trapped errors, that cause execution to stop immadiately and
untrapped errors that go unnoticed and later cause arbitrary behaviour. An untrapped error, for example, is
accessing data past the end of an array in absence of run time bounds checks. A trapped error would be division
by zero or accessing an illegal address.

[@cardelli-96] calls a language a safe language if untrapped errors are impossible in it.
The author suggests declaring a subset of possible execution errors as forbidden errors
(all of the untrapped and some of the trapped erros) and
says that a program can be called "well behaved" if no such forbidden errors can happen during execution.

**TODO:**
- [Sergio Benitez: Short Paper: Rusty Types for Solid Safety](benitez-ts)

[benitez-ts]: http://delivery.acm.org/10.1145/3000000/2993604/p69-benitez.pdf?ip=176.63.29.106&id=2993604&acc=OA&key=4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E16F2E899256EF4E3&__acm__=1544294467_31c2f304e83b1e3aa7798f12058b3af8

## Formalization of type systems

> How can we guarantee that well typed programs are really well behaved? [...]
> Formal type systems are the mathematical characterizations of the informal type systems
> that are described in programming language manuals. Once a type system is formalized, we can
> attempt to prove a type soundness theorem stating that well typed programs are well behaved.
> If such a soundness theorem holds, we say that the type system is sound.
>
> [@cardelli-96, p. 7]

Most materials on the formalization of type systems are dense and get very abstract quickly.
Here, I'd like to briefly introduce the basic concepts and standard notation used when
discussing formal type systems. Hopefully, by the end of this introduction I'll have presented
just enough theoretical foudation that I can also talk about what this leads to in practice.

An expression is a syntactically correct fragment of a program that can be evaluated to a value.
Type systems associate expressions with types. We call this the _has type_ relationship:
$e : M$, where expression $e$ has type $M$. This is called a judgement. Judgements could take on
various other forms:

\begin{tabular}{lll}
    ${n = n1 + n2}$ & $n$ is the sum of ${n1}$ and ${n2}$ \\
    \Tau ${type}$ & \Tau is a type \\
    and & so & on \\
\end{tabular}

Judgements are used to build inference rules of the form

\begin{equation*}
    \frac{J_{1} \ldots J_{n}}{J}
\end{equation*}

Where the judgements ${J_{1} \ldots J_{n}}$ above the line are called the premisses and $J$ is the conclusion.
We read the above expression as "from the premisses ${J_{1} \ldots J_{n}}$ we can conclude $J$".
If there are no premisses (meaning if $n$ is 0), then the rule is an axiom.
An inference rule can be read as stating that the premises are sufficient for the conclusion:
to show $J$, it is enough to show ${J_{1} \ldots J_{n}}$ .

In a program, the type of a variable can only be decided by looking at its context which is defined by
the declarations of the variables. We can think of context as a lookup table of (variable, type) pairs.
In the standard notaton, context is denoted by the greek letter Gamma:

\begin{equation*}
    \Gamma \Rightarrow e : T
\end{equation*}

Which we read as "expression $e$ has type $T$ in context $\Gamma$".

[@pfpl-2016], [@cardelli-96], [@ranta2012]

**TODO: add note about proofs and type checking statements (valid)**

**TODO: some terminlogy:**
in [@cardelli-96] : "How type systems are formalized" and "The language of type systems"!
similar notation here:
http://www.cse.chalmers.se/edu/year/2015/course/DAT150/lectures/proglang-07.html
and here:
https://sergio.bz/docs/rusty-types-2016.pdf

**TODO: references to Pierce: http://michaelrbernste.in/2014/02/17/what-is-a-type-system-for.html**

**TODO: some parts from this book maybe?**
    - http://pl.cs.jhu.edu/pl/book/book.pdf

**TODO: end note: transition from formal type systems to the topic of type checking**

# Type checking
> ... [static typing] ... consists in detecting a
> large family of errors: the application of operations to objects over which they are not defined [...]
> This is achieved by grouping the
> objects handled by the program into classes: the types, and by abstractly simulating the execution
> at the level of types, following a set of rules called the type system.
> 
> [@leroy-phd, p. 3]

Type checking is the process of verifying that the constraints posed by the type system are not violated
by the program. Type checking can be done by automated tools called typecheckers, which are usually
built into compilers or linkers.

http://www.cse.chalmers.se/edu/year/2015/course/DAT150/lectures/proglang-07.html

## Static type checking
Programmers make errors. Advanced programming languages should allow the automatic checking of inconsistencies
in programs. The most popular of these consistency checks is called static typing.

> The strength of static typing is that it guarantees the absence of type errors in the programs it
> accepts. The weakness of static typing is that it rejects some programs that are in fact correct, but
> too complex to be recognized as such by the type system used. From this tension follows the search
> for more and more expressive type systems [...]
>
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
static analysis cannot deftermine that this is the case.

[@pierce-types-and-prog]

...

### Advantages of static type checking

- performance
- documentation
    - it doesn't drift like comments do!
- tools and analysis
- correctness

[@debating-type-systems]

...

> After all, compiler-imposed constraints on data types encouraged rigorous coding and precise thinking.
> 
> [@oracle-generics]

## Dynamic type checking
...

[link](wiki-dynamic-type-checking)

[wiki-dynamic-type-checking]: https://en.wikipedia.org/wiki/Type_system#Dynamic_type_checking_and_runtime_type_information

### Advantages of dynamic type checking
- faster prototyping: shorter edit-compile-test cycles
- productivity
    - short term gains, long term losses?
- flexibility

[@parmer-type-systems]

## Gradual typing
**TODO: just a short mention that such things also exist**

http://wphomes.soic.indiana.edu/jsiek/what-is-gradual-typing/

## Type checking algorithms
[link](letswrite)

[letswrite]: https://speakerdeck.com/igstan/lets-write-a-type-checker

## Type inference
Type inference is the process of automatically (instead of manually, by the programmer) assigning types
to expressions in a program by examining the operations that are performed on them.

- not to be confised with dynamic typing! type inference is still static (before execution)!
-

**TODO: pros/cons**

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
>
> [@pierce-types-and-prog, p. 10]

## Evolution of type systems
**TODO:**

- the different stages of development
- important innovations
- timeline

## The future: interesting new developments
- https://graydon2.dreamwidth.org/253769.html

## Advanced type systems
**TODO: what makes them advanced?**

- look at Haskell and similar languages
- https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system
- https://en.wikipedia.org/wiki/Type_system#Specialized_type_systems

# Classification of type systems
- http://blogs.perl.org/users/ovid/2010/08/what-to-know-before-debating-type-systems.html
    - sound
    - static / dynamic
        - NOT strong/weak!
    - explicit(manifest) / implicit
    - structural / nominal
    - duck typing

"are unsound type systems wrong?"
http://frenchy64.github.io/2018/04/07/unsoundness-in-untyped-types.html

...

> The first statically typed languages were explicitly typed by necessity.
> However, type inference algorithms - techniques for looking at source code with no type declarations at all,
> and deciding what the types of its variables are - have existed for many years now
>
> [@debating-type-systems]

...

**?What is the difference between dynamic type checking and a runtime error?**

## Polymorphic typing

### Abstractions and types
- [Fleury: abstractions](fleury-abs)
- [destroyallsoftware: types](destroyall)
- [types in go](ardanlabs)
- [Abstract types and the dot notation](leroy-dot)

[fleury-abs]: http://ryanfleury.net/blog#a_theoretical_examination_of_the_abstraction
[destroyall]: https://www.destroyallsoftware.com/compendium/types?share_key=baf6b67369843fa2
[ardanlabs]: https://www.ardanlabs.com/blog/2013/07/understanding-type-in-go.html
[leroy-dot]: https://xavierleroy.org/bibrefs/Cardelli-Leroy-dot.html

**TODO: such a great quote! need to connect it somehow**

> An ADT's user need not know how the object it represents is implemented [...]
> In addition to the intellectual leverage for programmers who can take bigger strides in their thoughts,
> it provides flexibility in modifying the ADT implementation
>
> [@tt-oop]

Polymorphism is closely related to the concept of abstraction.
It is the concept of having internally different objects that provide the same interface.
Even though they implement different behaviour, they look the same from the outside and so they can be used
interchangeably. This frees their users (other entities in the program that use them) from having to differentiate
between them and allows them to ... **TODO: finish note**

### Parametric polymorphism - Generics
- https://docs.oracle.com/javase/tutorial/java/generics/index.html

### Subtyping

### Ad-hoc polymorphism - Typeclasses
**TODO: typeclasses**

- https://en.wikipedia.org/wiki/Polymorphism_(computer_science)
- https://xavierleroy.org/bibrefs/Leroy-unboxed.html
- https://en.wikipedia.org/wiki/Type_system#Polymorphism_and_types

## Dependent types 
...

## Algebraic data types
Algebraic data types are composite types: they are defined as a combination of other types.
In most imperative languages conditional expressions (if-else statements) can define any number of branches
that are not checked for consistency. Execution enters these branches based solely on their predicates,
boolean valued "functions". This means that by mistake, they can overlap or fail to handle all possible cases.
In functional languages, with the help of pattern matching algebraic data types facilitate a type safe
implementation of conditional expressions. They let us define the branching logic in terms 
of a composite type and allow the type system to check whether we we covered all the cases.

[@parmer-type-systems]

- Sum types
    - Maybe / Option
        - note: "nullable" in dynamic languages where ther is NULL, "option" or "maybe" in static languages
        - Null pointer exceptions vs. "Maybe" types
    - Try
- Product types

# Type systems and software security
**TODO: google "type systems and security"**

- provable correctness
- defensive mechanisms provided by type systems
    - look at the most common sources of vulnerabilities, see if type systems could help
        - need data!
- solving injection with a type system
    - http://blog.moertel.com/posts/2006-10-18-a-type-based-solution-to-the-strings-problem.html

## CAR Hoare's presentation on `NullPointerException`s (The Billion Dollar Mistake - 2009)
**TODO: summarize his thoughts**

- runtime bound chacks in languages? how do these work?
- https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare
- 31:10 great notes about what to expect from programming languages
- 31:40 "formal verification"
- 33:05 "if the validity of the local application of a rule to a small bit of program depends on properties which can only be established by the scan of the program as a whole then you know that you've done abad job as a language designer"
- 37:34 "now, the real commercial imperative which requires greater attention paid to formal correctness of the programs is the virus."
    - "it reaches paths of your program that normal execution never reaches"
    - "it's no longer adequate to test your program against all the cases that are likely to arise..."
- 50:00 great thoughts about the `jmp` machine instruction

# Type systems and program performance
**TODO: type systems allowing certain compiler optimizations?**

- https://xavierleroy.org/publi/intro-tic98.pdf

To generate efficient machine code, precise knowledge about the size of the data is required. This can be derived from
static type information - memory size and layout. Languages without static typing cannot be compiled as efficiently,
all data representations must fit a default size.

> In general, accurate type information at compile time leads to the
> application of the appropriate operations at run time without the need of expensive tests.
>
> [@cardelli-96, p. 6]

If a language's type system doesn't allow casts between incompatible pointer types, then those can't point to the
same location in memory which in turn guarantees that load/store operations through those pointers cannot interfere.
This allows the compiler to do more aggressive instruction scheduling.

Type information is also useful in the optimization of method dispatch in object-oriented languages.
[@leroy-intro-tic98]

> General method dispatch is an expensive operation, involving a run-time lookup of the code associated to the method in
> the object’s method suite, followed by a costly indirect jump to that code. In a class-based language, if the actual
> class to which the object belongs is known at compile-time, a more efficient direct invocation of the method code can be
> generated instead.
>
> [@leroy-intro-tic98 p. 1]

...

> Not having static type system information makes it hard to model control flow in the compiler,
> which leads to overly conservative optimizers.
>
> [@duffy-error-model]

## The cost of types
- overhead of type systems during runtime?
    - will it be visible in the complied program?
    - how much code does it add?
    - does it decrease performance? after all, we are doing more "checks" (implicitly by the types system) ???
- cost of type systems (van értelme megkülönböztetni language-design-time és programming-time költségeket?)

## Run-time type information

...

> Another operation that relies heavily on run-time type information is marshaling and un-marshaling between
> arbitrary data structures and streams of bytes – a crucial mechanism for persistence and distributed programming.
>
> [@leroy-intro-tic98 p. 5] 

### Type erasure

...

https://en.wikipedia.org/wiki/Generics_in_Java#Problems_with_type_erasure

# Comparing type systems of different programming languages
**TODO: short intro, why the chosen languages**

## Methodology
**TODO:find what methods are used for comparing type systems**

## Languages
**TODO: a chapter for each language**

- assembly
    - explain the advantages/motivation of not having a type system!
- javascript
- python
- C / C++
- java, scala
- any ML language
- Agda
- Rust

# References
