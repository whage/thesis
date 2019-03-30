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
