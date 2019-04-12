# Examination of the evolution of type systems in programming languages

# Planned main themes
- type systems in programming languages
- static analysis, formal verification
- building a programming language and a static analyzer
    - incrementally adding type system features to a toy language and examining the costs/benefits
- building a type checker
    - maybe try it for HCL (Terraform)?

# Introduction, personal motivation
I first experienced working with staticly typed languages at the university.
After I started learning and working with C# I was struck by how much the
type system aided my development and how much the typechecker speeded up my work.
The type system made me think more thoroughly,
it allowed me to change parts of the program and be confident that I didn't break it.
It felt like a much more pleasant way of writing software than I had done before so I became
more and more interested in the possibilities of static checking and type systems.
I started wondering what else was out there that could boost programmer productivity
and software quality even further. This is how I chose type systems as the topic of my thesis.

My goal with this thesis is to gain a more fundamental understanding of programming languages,
the structures and algorithms behind them.
First, I'll survey the history and theoretical background of type systems.
I'll look at how type systems evolved, and how they could be categorized.
I'll compare the type systems of widely used programming languages and will try to
give an overview of the possibilites of recent advances in type systems and programming language design.

# Type systems
- "A primer on type systems"
    - read HN thread: https://news.ycombinator.com/item?id=19035684
    - read REFERENCES at the bottom of the article too!
        - http://michaelrbernste.in/2014/02/17/what-is-a-type-system-for.html
        - http://www.cis.upenn.edu/~bcpierce/tapl/
- what are they?
- what do they give us?
- tradeoffs?

> Modern software engineering recognizes a broad range of formal methods for helping ensure that a system behaves correctly [...]
> by far the most popular and best established lightweight formal methods are type systems.
>
> [@pierce-types-and-prog]

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

**my own**
By using the facilities provided by the type system, we can add more information in our programs. We create a
safety-net against execution errors by making it possible for automated tools to verify our programs.

**? what errors are NOT type errors?**

...

> When a programming language evolves a more elaborate type system, it gains a more finely grained rule set [...]
>
> [@wiki-type-systems]



# The history of type systems
The first type systems appeared in the 1950s, when the desiners of the Fortran language wanted to make
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

# Type theory
Type theory is the study of type systems.

...

- https://ncatlab.org/nlab/show/type+theory#CategoricalSemantics
- what it is
- mention category theory too?

# Language safety

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

[@cardelli-96] differentiates between _trapped errors_, that cause execution to stop immadiately and
_untrapped errors_ that go unnoticed and later cause arbitrary behaviour. An untrapped error, for example, is
accessing data past the end of an array in absence of run time bounds checks. A trapped error would be division
by zero or accessing an illegal address.
He calls languages where untrapped errors are impossible _safe languages_.


- Sergio Benitez: Short Paper: Rusty Types for Solid Safety
    - http://delivery.acm.org/10.1145/3000000/2993604/p69-benitez.pdf?ip=176.63.29.106&id=2993604&acc=OA&key=4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E16F2E899256EF4E3&__acm__=1544294467_31c2f304e83b1e3aa7798f12058b3af8

- https://stackoverflow.com/questions/260626/what-is-type-safe
    - "A short answer: a language is considered type-safe if no operation leads to undefined behavior."

- https://en.wikipedia.org/wiki/Type_safety

# Type checking
Type checking is the process of verifying that the constraints posed by the type system are not violated
by the program. Type checking can be done by automated tools called the typecheckers, which are usually
built into compilers or linkers.

http://www.cse.chalmers.se/edu/year/2015/course/DAT150/lectures/proglang-07.html

## Static type checking
Programmers make errors. Advanced programming languages should allow the automatic checking of inconsistencies
in programs. The most popular of these consistency checks is called static typing.
[@leroy-phd]

> ... [static typing] ... consists in detecting a
> large family of errors: the application of operations to objects over which they are not defined (the
> integer addition to a boolean and a character string, for instance). This is achieved by grouping the
> objects handled by the program into classes: the types, and by abstractly simulating the execution
> at the level of types, following a set of rules called the type system.
> 
> The strength of static typing is that it guarantees the absence of type errors in the programs it
> accepts. The weakness of static typing is that it rejects some programs that are in fact correct, but
> too complex to be recognized as such by the type system used. From this tension follows the search
> for more and more expressive type systems [...]
>
> [@leroy-phd]

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

## Benefits of Static Types
- performance
- documentation
- tools and analysis
- correctness

[@debating-type-systems]

...

> After all, compiler-imposed constraints on data types encouraged rigorous coding and precise thinking.
> 
> [@oracle-generics]

## Dynamic type checking
...

https://en.wikipedia.org/wiki/Type_system#Dynamic_type_checking_and_runtime_type_information

# Abstractions and types
- http://ryanfleury.net/blog#a_theoretical_examination_of_the_abstraction
- https://www.destroyallsoftware.com/compendium/types?share_key=baf6b67369843fa2
- https://www.ardanlabs.com/blog/2013/07/understanding-type-in-go.html
- "Abstract types and the dot notation": https://xavierleroy.org/bibrefs/Cardelli-Leroy-dot.html

# Evolution of type systems

- fejlődés szakaszai, lényeges újítások
- különböző szintek - mi szerint? "fejlettség"?

# Classification of type systems
- http://blogs.perl.org/users/ovid/2010/08/what-to-know-before-debating-type-systems.html
    - sound
    - static / dynamic
        - NOT strong/weak!
    - explicit(manifest) / implicit
    - structural / nominal
    - duck typing

...

> The first statically typed languages were explicitly typed by necessity.
> However, type inference algorithms - techniques for looking at source code with no type declarations at all,
> and deciding what the types of its variables are - have existed for many years now
>
> [@debating-type-systems]

...

**?What is the difference between dynamic type checking and a runtime error?**

# Polymorphic typing
...

https://en.wikipedia.org/wiki/Polymorphism_(computer_science)
https://xavierleroy.org/bibrefs/Leroy-unboxed.html
https://en.wikipedia.org/wiki/Type_system#Polymorphism_and_types

# Gradual typing
...

http://wphomes.soic.indiana.edu/jsiek/what-is-gradual-typing/

# The cost of types
- overhead of type systems during runtime?
    - will it be visible in the complied program?
    - how much code does it add?
    - does it decrease performance? after all, we are doing more "checks" (implicitly by the types system) ???
- cost of type systems (van értelme megkülönböztetni language-design-time és programming-time költségeket?)

# Contracts
- TODO: read through this paper, chack SO link
    - https://pdfs.semanticscholar.org/653b/fc1c9ede840964f7a6f0bb1e13d77bf9d2da.pdf
    - https://stackoverflow.com/a/5965869/1772429
    - read the part on contracts in duffy-error-model again!

> ontracts begin where the type system leaves off. A type system allows you to encode attributes of variables using types.
> A type limits the expected range values that a variable might hold. A contract similarly checks the range of values
> that a variable holds. The difference? Types are proven at compile-time through rigorous and composable inductive rules [...]
> Contracts are proven at compile-time where possible and at runtime otherwise [...]
>
> [@duffy-error-model]

# Generics
- https://docs.oracle.com/javase/tutorial/java/generics/index.html
- where do they fit in?

# Advanced type systems
TODO:
    - look at Haskell and similar languages
        - https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system

https://en.wikipedia.org/wiki/Type_system#Specialized_type_systems

## Dependent types 
...

## Non-Null Types - **?do we need this section?**
...

## CAR Hoare prezentációja a null-pointer exception-ről (The Billion Dollar Mistake - 2009)
- runtime bound chacks in languages? how do these work?
- https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare
- 31:10 környékén nagyon jókat mond programnyelvekkel szemben tartott elvárásokról
- 31:40 körül "formal verification"
- 33:05 "if the validity of the local application of a rule to a small bit of program depends on properties which can only be established by the scan of the program as a whole then you know that you've done abad job as a language designer"
- 37:34 "now, the real commercial imperative which requires greater attention paid to formal correctness of the programs is the virus."
    - "it reaches paths of your program that normal execution never reaches"
    - "it's no longer adequate to test your program against all the cases that are likely to arise..."
- 50:00 körül a gépi "jump" utasítással kapcsolatban mond nagyon jókat

# Null pointer exceptions vs. "Maybe" types
- amit Tomival beszéltünk

# Type systems and software security
- TODO: google "type systems and security"
- demonstrálható helyesség
- típusrendszerek által nyújtott védelmi mehanizmusok
    - sérülékenységek gyakori forrásai? kell róla adat!
- solving injection with a type system
    - http://blog.moertel.com/posts/2006-10-18-a-type-based-solution-to-the-strings-problem.html

# Type systems and program performance

- type systems allowing certain compiler optimizations?
    -   https://xavierleroy.org/publi/intro-tic98.pdf

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

# Run-time type information

...

> Another operation that relies heavily on run-time type information is marshaling and un-marshaling between
> arbitrary data structures and streams of bytes – a crucial mechanism for persistence and distributed programming.
>
> [@leroy-intro-tic98 p. 5] 

# Type erasure

...

https://en.wikipedia.org/wiki/Generics_in_Java#Problems_with_type_erasure

# Promising areas of research
- https://graydon2.dreamwidth.org/253769.html

# Implementing a type system
on writing a language from scratch:
    - https://medium.freecodecamp.org/the-programming-language-pipeline-91d3f449c919

# Suggestions for further studies
- How computer science / software engineering curriculums could be 

# TODO
- Xavier Leroy's publications
    - https://xavierleroy.org/research.html
        - this site is a GOLD MINE of information on type systems!!!
- Chris Lattner's PhD thesis: "LLVM: An Infrastructure for Multi-Stage Optimization" http://llvm.org/pubs/2002-12-LattnerMSThesis.html
- my good old bookmarked page: http://blog.fogus.me/2011/09/08/10-technical-papers-every-programmer-should-read-at-least-twice/
- http://canonical.org/~kragen/memory-models/
- formal verification: https://www.sciencedirect.com/science/article/pii/S0304397599002753
- do a proper bibliography, instead of just providing links to papers!
- Cleanroom method: http://infohost.nmt.edu/~al/cseet-paper.html
    - not very clean, but might be useful
- there are some nice references in [Vorobyov], check them out!
    - D EUTSCH , A.: Static verification of dynamic properties. for example
- "Software Foundations" books by Penn
    - https://softwarefoundations.cis.upenn.edu/current/index.html
- FIX page numbers in citations
- learn basic OCaml / Haskell to really get a feel for their type systems
    - https://protoship.io/blog/rails-on-ocaml/?fbclid=IwAR19V_qKFInMulovHh9VXGnYSQYaDh9C_dbLhuaEDGlDu7bV9UXy1Y5M00k

# QUESTIONS
- wikipedia links? shall I include them?
- how to properly reference online content (articles, blog posts) ?

# META
- convert markdown to other document types: https://pandoc.org/
- https://github.com/tompollard/phd_thesis_markdown
- MLA citation guidelines: http://www.easybib.com/guides/citation-guides/mla-format/
- `.bib` format documentation: http://bib-it.sourceforge.net/help/fieldsAndEntryTypes.php#article

# References
