# Planned main themes
- "software" + "engineering"
- type systems in programming languages
- static analysis, formal verification
- building a programming language and a static analyzer
    - incrementally adding type system features to a toy language and examining the costs/benefits

# Possible titles
- Tools of software engineering: (advanced)? type systems
- type systems and static analysis
- 

# Introduction, personal motivation

Divatos manapság a szoftverfejlestést mérnöki szakmák közé sorolni. Ezzel szemben a szoftverfejlesztői gyakorlatban ritkán
folyamodunk ...,  mint azt a hagyományos értelemben vett mérnöki "ágazatokban" teszik.

...

My personal experience is, however, that software development is generally practiced at a much more "informal" level.

...

Egyfelől méltatlannak érzem "mérnöki munkaként" feltüntetni a szoftverfejlesztés ilyen módját, másrészről viszont
nem látom kisebb kihívásnak egy szoftverrendszer megvalósítását, mint az építészek, gépészek, villamosmérnökök által
végzett munkákat.

Dolgozatomban szeretnék rámutatni a szoftverfejlesztői gyakorlat hiányosságaira ...
Megpróbálom megfogalmazni, mit érthetünk mérnökség alatt, hogyan vetíthetjük ezt a szoftverfejlesztésre,
miként jutahatunk közelebb... fejelszthetjük tovább eszközeinket... hogyan módosíthatjuk bevett gyakorlatainkat...

Ha már megvan, hogy mitől lesz "engineering", akkor nézzük meg, hogy mely eszközeink használatával/javításával juthatunk előrébb:
programnyelvek, típusrendszerek.

...

- Mi alapján mondhatjuk, hogy jó minőségű az elkészült szoftver? - reasoning / verification
- How can we reason about a program? -> type systems!
- How can we automate more of the reasoning? -> static analysis

...

Mik a legnagyobb kihívások a szoftverfejesztésben?

- managing complexity, huge state spaces
- managing systems of components, reasoning about each component
- quality assurance
    - testing is not the only way of achieving high quality (see http://blogs.perl.org/users/ovid/2010/08/what-to-know-before-debating-type-systems.html)

...
röviden saját tapasztalatról:
- first experience with staticly typed languages: C#, java
- how I felt more confident wiritng code
- how the type system helped think more thoroughly
- so many errors were caught during compilation

...

A dolgozatom fő célja, hogy mélyebb tudást szerezzek a programnyelvek felépítésében, működésében.

# A brief history of engineering
...

**TODO: some citation from "Whither software engineering"**

TO READ:
    - https://news.ycombinator.com/item?id=14527776
    - https://vanemden.wordpress.com/2017/06/07/is-software-engineering-possible/
    - https://pdfs.semanticscholar.org/3a6b/0506b8b922d7e6cc933a39dc165b5f34797e.pdf


**TODO: some citation from "out of the tar pit"**

- https://en.wikipedia.org/wiki/Structured_analysis
- https://en.wikipedia.org/wiki/Software_engineering
- https://en.wikipedia.org/wiki/Systems_analysis

# "Software engineering"
By the 1960s, computer performance was growing rapidly. The intuitive programming practices, the general
"code-and-fix" style of programming people used started to become more and more inadequate,
software projects ran over budget and schedule, the resulting programs were unreliable, insecure and inefficient,
the complexity of the systems was unmanageable.

[@software-engineering-cape-town]
[@kimble-software-crisis]

> The standard model in software development is, and has always been, to follow the test-debug cycle.
> I call it the standard model not because of any virtues, but because of the lack of alternatives,
> unless it would be to prove software correct, a notion universally rejected as utterly unrealistic [...]
>
> [@is-se-possible]

This phenomenon later became known as the software crisis.
To address these issues, The NATO Software Engineering Conferences were held in 1968 and 1969.

> The conferences were attended by international experts on computer software who agreed on defining best practices
> for software grounded in the application of engineering. [...]
> The conferences played a major role in gaining general acceptance for the term software engineering.
>
> [@wiki-nato-conferences]

The main themes of the first conference were the following:
    - design strategies and techniques
    - scale and reliability
    - planning, production and communication
    - tools and concepts
    - replication, distribution, maintenance
    - testing and monitoring
    - software pricing

The second one discussed:
    - languages
    - formal correctness, debugging
    - portability
    - large systems
    - working papers (publications)

[@nato-69]
...

> Coining the term 'software engineer', with the word 'engineer' being something people can relate to and see it
> as a respectable profession, I think can help a bit in conveying that yes, what we do is a real and important job.
>
> [@hn-joe-z]

...

> The principles of static verification of dynamic properties are based on a paradigm that is at the heart of other
> engineering activities. Activities such as designing a bridge, computing the trajectory of a satellite or optimizing the
> shape of a plane wing are all based on applied mathematics, whose use is facilitated by high-speed processors. If we
> want to formalize this statement, we would say that all these engineering activities are based on a central paradigm that consists
> of a three-step method:
>    - Modeling a physical world system as a set of mathematical equations
>    - Solving these equations using high-speed processors
>    - Using the solutions to these equations to predict the behavior of the physical system
>
> [@deutsch-static-verification]

...

> Software crafting is very much like building a bridge back in the days before xrays were around to detect
> cracks in metal and before metallurgy and casting were very reliable. That was back in the 1800s when
> anything made of metal could and did fail at any time - including bridges - quite often catastrophically.
> A high percentage of bridges folded, over time. How do you "engineer" what you can't measure
> (such as whether a metal beam is fatally flawed by a large crack inside)? You don't. We're getting there slowly.
>
> [@hn-nomentatus]

# Software quality, regulations
...

> Statistically speaking, programs “work.”
> Maybe statistical correctness is okay for scripting languages, but for the lowest levels of an operating system,
> or any mission critical application or service, this isn’t an appropriate solution.
>
> [@duffy-error-model]

## Software certification - **?do we need this section?**
https://en.wikipedia.org/wiki/DO-178B
https://en.wikipedia.org/wiki/DO-178C
- others?

# Software reliability
...
check this out: https://users.ece.cmu.edu/~koopman/des_s99/sw_reliability/

# Testing
Generally, testing means running a program within a controlled environment and checking whether its outputs / effects match the
expectations.

> Program testing can be used to show the presence of bugs, but never to show their absence
>
> Edsger Dijkstra

Testing represents only a small sampling of all possible computations and therefore is never
adequate to assure the expected behaviour under all possible conditions. Still, testing is the preferred method to
"show" that a program satisfies its requirements, primarily because formal methods are not nearly as scalable.
The level of detail needed to create a formal specification of a program can be overwhelming.
[@debugging-testing-verification]

# Static analysis
> Static program analysis is the automatic determination of run-time properties of programs, which considers
> run-time errors at compilation time automatically, without code instrumentation or user interaction.
>
> [@vorobyov-krishnan]

**TODO: find some good papers on static analysis!**
**TODO: static analysis vs formal verification - how are they different?**

# Formal methods
...

# Logic and proofs
...

## Formal specification
...

## Formal development
...

## Formal verification
Formal verification is the process of proving or disproving that a program meets a formal specification.

> We begin with a software program written in a programming language (let P be the program written in language L).
> The program is expected to satisfy a set of specifications, where those specifications are written in a
> specification language [...].
> In most real-world cases, the [...] specification language is the natural language of the development team (i.e., English, Spanish, etc.)
> [...]
> In order to verify “functional correctness” of a program, one needs to capture the model of the
> behavior of the program in a formal language or use the program itself. In most commercial software
> development organizations, there is often no formal specification of the program being built. Formal
> verification is routinely used by only small pockets of the industrial software community, particularly
> in the areas of protocol verification and embedded systems.
> 
> [@debugging-testing-verification]



- bele kéne menni ebbe is - típusok és verifikáció kapcsolata
- formal verification: a very costly but very effective tool for producing high-quality software
- Adam Chlipala: http://adam.chlipala.net/
    - "deep spec" project: https://deepspec.org/main
        - "We focus on the specification and verification of full functional correctness of software and hardware."
- szoftver verifikáció
    - ILA KMOOC kurzusban ezek a témák egész érdekesek
        - 7. modul: SMT
        - 7. modul utolsó slide-ja: érdekes problémák!
        - https://www.youtube.com/watch?v=79StGtIh8i8

## Model checking - **?érdemes erről beszélni? talán nem kéne ennyire részletekbe menni**
- an automated verification technique
- takes a model of a system (a program) and a specification (in formal logic)
- model checking algorithm: an exhaustive search of all the possible states / state space exploration
    - state space: all possible states the system could enter during execution
    - sate space: graph, (states, transitions)
- a model checker either reports the notion of successful verification or a counterexample if verification fails
- if the state space is not finite, approxiamations are necessary
- bounded model checking: the number of explored states are bounded, bugs can exist beyond the bound
- a sufficiently abstract model must be providd so the model checker can avoid less meaningful parts of the state space
[@vorobyov-krishnan]

## Prerequisites of formal verification (what it costs)
...

**own thoughts**
We can't measure with exact/infinite precision in the real world. The world of software is slightly different as it is based on discreet
- and thus finite sets of - values but still the problem space might be practically infinite and in that case we can't construct perfect software.
A key component of engineering is being able to plan and measure precision. We need to know how much that extra bit
of precision costs. Going beyond a certain pint may not be impossible technically but it could very well be infeasible
from an economical point of view.

There are many **?stages?** between the completely useless programs and the software that are proven to meet a specification.
Maybe the cost of using formal verification is too high for most commercial software project.
In my experience, most software companies try to **?minimize?** time-to-market and are willing to release "good-enough" software.
From a business standpoint, this is likely the optimal approach.

**?There is still hope for formal methods?**. In safety-critical systems like transportation, infrastructure,
medicine or financial services for example, where the potential failures can be catastrophic, or in embedded systems,
where software are reasonably small, tools for producing verified software systems **?might be in demand?**.

# The limits of formal methods, un-/decidability, halting problem

> ... Given that we can't actually check the correctness of a program, there are two approaches that help us make approximations:
>
> - Testing: establishes upper bounds on correctness
> - Proof: establishes lower bounds on correctness
>
> The problem with proofs, though, is the same as the problem with documentation.
> When the code is being maintained by three programmers and changing seven times per day, maintaining the correctness proofs falls behind.
>
> [@debating-type-systems]

# The cost of formal methods
...

# Tools of software engineering (increasing the quality of the software product)

The question remains: how can we decrease the costs of producing high quality software and what tools can we give to our developers?
tadaaaa: TYPE SYSTEMS!

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
The main purpose of type systems is to reduce possibilities for bugs in computer programs by defining valid operations
on types. The type system associates a type with each value in the program and then by examining the flow of these values
attempts to prove that no operation violates them.

Such a violation is called a **type error**. It is an inconsistency in a program according to the type system's rules.
Exactly what constitutes a type error is defined by the type system of the language.

[@wiki-type-systems]



**?what errors are NOT type errors?**

...

> When a programming language evolves a more elaborate type system, it gains a more finely grained rule set [...]
>
> [@wiki-type-systems]





# Type theory
Type theory is the study of type systems.

...

- https://ncatlab.org/nlab/show/type+theory#CategoricalSemantics
- what it is
- mention category theory too?

# Type safety - **legyen alaposan kifejtve**
- Sergio Benitez: Short Paper: Rusty Types for Solid Safety
    - http://delivery.acm.org/10.1145/3000000/2993604/p69-benitez.pdf?ip=176.63.29.106&id=2993604&acc=OA&key=4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E16F2E899256EF4E3&__acm__=1544294467_31c2f304e83b1e3aa7798f12058b3af8

- https://stackoverflow.com/questions/260626/what-is-type-safe
    - "A short answer: a language is considered type-safe if no operation leads to undefined behavior."

- https://en.wikipedia.org/wiki/Type_safety

**own thoughts**
"a nyelv ne engedje, hogy futás közben az adatok "jelöletlenül" változtassák a típusukat"

# Type checking
...

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

Static type systems are "conservative", meaning that they sometimes reject programs that actually behave
well at run time. For example

```
if <complex test> then 5 else <type error>
```

will always be rejected as ill-typed even if `<complex test>` always evaluates to true, because
static analysis cannot deftermine that this is the case.

[@pierce-types-and-prog]

...

> Not having static type system information makes it hard to model control flow in the compiler,
> which leads to overly conservative optimizers.
>
> [@duffy-error-model]

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
- mi volt elötte, mi szülte az igényt, hogyan alakultak ki
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

# Benefits of Static Types: http://blogs.perl.org/users/ovid/2010/08/what-to-know-before-debating-type-systems.html
- performance
- documentation
- tools and analysis
- correctness

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

If a language's type system doesn't allow casts between incompatible pointer types, then those can't point to the
same location in memory which in turn guarantees that load/store operations through those pointers cannot interfere.
This allows the compiler to do more aggressive instruction scheduling.

Type information is also useful in the optimization of method dispatch in object-oriented languages:

> General method dispatch is an expensive operation, involving a run-time lookup of the code associated to the method in
> the object’s method suite, followed by a costly indirect jump to that code. In a class-based language, if the actual
> class to which the object belongs is known at compile-time, a more efficient direct invocation of the method code can be
> generated instead.
>
> [@leroy-intro-tic98 p. 1]



[@leroy-intro-tic98]

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

# QUESTIONS
- wikipedia links? shall I include them?
- how to properly reference online content (articles, blog posts) ?

# META
- convert markdown to other document types: https://pandoc.org/
- https://github.com/tompollard/phd_thesis_markdown
- MLA citation guidelines: http://www.easybib.com/guides/citation-guides/mla-format/

# References
