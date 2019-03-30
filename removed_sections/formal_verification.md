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
