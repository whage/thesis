# TODO
- Xavier Leroy's publications
    - https://xavierleroy.org/research.html
        - this site is a GOLD MINE of information on type systems!!!
- Chris Lattner's PhD thesis: "LLVM: An Infrastructure for Multi-Stage Optimization" http://llvm.org/pubs/2002-12-LattnerMSThesis.html
- my good old bookmarked page: http://blog.fogus.me/2011/09/08/10-technical-papers-every-programmer-should-read-at-least-twice/
- http://canonical.org/~kragen/memory-models/
- there are some nice references in [Vorobyov], check them out!
    - D EUTSCH , A.: Static verification of dynamic properties. for example
- "Software Foundations" books by Penn
    - https://softwarefoundations.cis.upenn.edu/current/index.html
- learn basic OCaml / Haskell to really get a feel for their type systems
    - https://protoship.io/blog/rails-on-ocaml/?fbclid=IwAR19V_qKFInMulovHh9VXGnYSQYaDh9C_dbLhuaEDGlDu7bV9UXy1Y5M00k
- look at these, maybe you'll find some type checking related stuff:
    - https://dhall-lang.org/
    - https://jsonnet.org/
- read this: https://blog.wesleyac.com/posts/language-todos
- intro to theorem proving: https://news.ycombinator.com/item?id=19659582
- "Rust: beyond the typechecker": https://blog.merigoux.ovh/en/2019/04/16/verifying-rust.html
- John Hopkins University course: Principles of programming languages
    - http://pl.cs.jhu.edu/pl/dateline.shtml

# BEST BOOKS - need to read them!
- http://www.cs.cmu.edu/~rwh/pfpl/2nded.pdf
- http://www.cis.upenn.edu/~bcpierce/attapl/

# QUESTIONS
- what errors are NOT type errors?

# META
- https://github.com/tompollard/phd_thesis_markdown
- Citation Style Language
    - https://citationstyles.org/
    - https://www.zotero.org/style
- markdown title page templates:
    - https://github.com/Wandmalfarbe/pandoc-latex-template/blob/master/examples/custom-titlepage/custom-titlepage.md
- LATEX
    - https://www.latex-tutorial.com/tutorials/amsmath/
    - https://www.rpi.edu/dept/arc/training/latex/LaTeX_symbols.pdf
    - https://www.overleaf.com/learn/latex/Subscripts_and_superscripts

# Related topics, decided to leave them out

## Implementing a type checker (?)
on writing a language from scratch:
    - https://medium.freecodecamp.org/the-programming-language-pipeline-91d3f449c919

# some good notes on type systems & type checking
http://www.cse.chalmers.se/edu/year/2015/course/DAT150/lectures/proglang-07.html

# Research motivation
google this !!: "Static vs. dynamic type systems: an empirical study about the relationship between type casts and development time pdf"
    - so many pdf results!

# Agda
http://learnyouanagda.liamoc.net/pages/introduction.html

# Megjegyzés a vizsgálóbizottságnak
\pagebreak

**Megjegyzés a tisztelt bíráló bizottságnak**: A dolgozatom jelen állapota egy köztes állapot,
több helyen tartalmaz feljegyzéseket, jelöléseket a további munkához.
A terület, amit választottam nagyobb, érdekesebb, mint először gondoltam,
jóval több tájékozódást és munkát igényel a részemről, mint számítottam, viszont
szándékomban áll mélységében áttekinteni és a hiányzó részeket kidolgozni.
A hiányzó fejezeteket a következő időszakban illetve a Szakdolgozat II. tágy keretein belül fogom
befejezni.

# Mike Grant: Principles of Programming Languages (2018)
https://pl.cs.jhu.edu/pl/book/book.pdf
https://book.huihoo.com/programming-languages/book/html/main.html#mainli1.html

# Collection of resources for studying type theory
https://github.com/jozefg/learn-tt

# static vs dynamic
https://softwareengineering.stackexchange.com/questions/122205/what-is-the-supposed-productivity-gain-of-dynamic-typing

# The Oregon Programming Languages Summer School links
links at bottom of github readme:
    - https://github.com/jozefg/learn-tt#learn-tt

This is incredible... many of the researchers I cited in my thesis have given lectures here!

# Thesis structure - really good notes!
https://seamk.libguides.com/instructionsforbachelorsthesis/thesisprocessandstructure

## The future: interesting new developments
- https://graydon2.dreamwidth.org/253769.html

# this guy seems passionate and knowledgeable about types
http://tomasp.net/blog/2015/against-types/

# magyar típusrendszer anyagok
https://people.inf.elte.hu/pgj/nytr_msc/ 
https://www.inf.elte.hu/dstore/document/788/Kaposi_Ambrus_Nyelvek%20t%C3%ADpusrendszere_jegyzet_2017.pdf
https://akaposi.github.io/hott_bevezeto.pdf

# markdown, latex page numbering
https://stackoverflow.com/a/38768279/1772429

# Let's write a type checker - youtube video + slides
https://www.youtube.com/watch?v=oPVTNxiMcSU
https://speakerdeck.com/igstan/lets-write-a-type-checker

===
===
===
**IDEA: create small programs for each concept in this section instead of examining languages at Section II separately!**
- example of a type systems feature
- what would happen if such feature were missing from the language?
===
===
===

# Hypotheses {-}

**hagyjuk, ha nem muszáj!**

1. Static type checking can measurably increase programmer productivity. **TODO: Likely false, there seems to be no evidence**
2. Using statically typed languages results in more reliable software.
3. Despite their advantages, languages featuring advanced type systems are rarely used in the industry because of cultural reasons.

\pagebreak

# Dynamic languages
**TODO: get some ideas from this: "The Unreasonable Effectiveness of Dynamic Typing for Practical Programs"**

# basic type systems links
https://lexi-lambda.github.io/blog/2020/01/19/no-dynamic-type-systems-are-not-inherently-more-open/
https://softwareengineering.stackexchange.com/questions/333643/what-is-a-type-system
https://thevaluable.dev/type-system-explained/

## RTTI
RTTI is used in the context of some statically typed languages like C++.
It means that some information about an object's type is made available to the programmer during run-time.

- dynamic casts - downcasting https://stackoverflow.com/a/2254183/1772429
    - maybe a note about static casts - "static downcast" is undefined behavior https://stackoverflow.com/a/47310910/1772429

**TODO: C++: dynamic_cast, typeid | Java: instanceof**
**TODO: RTTI and Reflection slides: https://www.cs.huji.ac.il/course/2004/ood/docs/lec08.pdf**
**TODO: connection between RTTI and reflection**

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

**TODO: summarize CAR Hoare's presentation on `NullPointerException`s (The Billion Dollar Mistake - 2009)**

- https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare
- 31:10 great notes about what to expect from programming languages
- 31:40 "formal verification"
- 37:34 "now, the real commercial imperative which requires greater attention paid to formal correctness of the programs is the virus."
    - "it reaches paths of your program that normal execution never reaches"
    - "it's no longer adequate to test your program against all the cases that are likely to arise..."
- 50:00 great thoughts about the `jmp` machine instruction

# Typescript unsoundness
https://medium.com/@yuhuan/covariance-and-contravariance-in-java-6d9bfb7f6b8e
https://blog.daftcode.pl/csi-python-type-system-episode-1-1c2ee1f8047c
https://blog.daftcode.pl/csi-python-type-system-episode-2-baf5168038c0
https://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)
https://en.wikipedia.org/wiki/Covariant_return_type

# Types and operations (removing this part, no real content here)
The next step for a programming langage with regards to type systems would be to define certain basic types and operations
for the values in the program. These help reduce the cognitive load on the programmer and make it possible to check
(either statically or dynamicall) whether some operation later in the code is considered legal or not.
Today we take for granted such a type system but this indeed is a language feature that wasn't there for the
first generations of computer programmers.

# Assembly

**TODO: Explain why assembly has no types! Are there any advantages of not having types?**

Typed Assembly Language papers (from around 1999) - Morrisett et al.
    - http://www.cs.cornell.edu/talc/papers.html
    - https://www.cs.princeton.edu/~dpw/papers/tal-toplas.pdf
    - https://www.cis.upenn.edu/~stevez/papers/MCGG99.pdf

**TODO: read all of these! good material!**
- https://cs.stackexchange.com/a/40098/30429
    - http://www.cse.chalmers.se/~peterd/papers/DependentTypesAtWork.pdf
- https://softwareengineering.stackexchange.com/a/401220/90623

Agda: https://plfa.github.io/

**TODO: revise after having tried such a language!**

## Type systems and software security
- solving injection with a type system
    - http://blog.moertel.com/posts/2006-10-18-a-type-based-solution-to-the-strings-problem.html
- security and modern type systems
    - https://blog.moertel.com/posts/2007-08-15-a-bright-future-security-and-modern-type-systems.html
