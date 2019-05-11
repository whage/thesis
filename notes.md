# TODO
- Xavier Leroy's publications
    - https://xavierleroy.org/research.html
        - this site is a GOLD MINE of information on type systems!!!
- Chris Lattner's PhD thesis: "LLVM: An Infrastructure for Multi-Stage Optimization" http://llvm.org/pubs/2002-12-LattnerMSThesis.html
- my good old bookmarked page: http://blog.fogus.me/2011/09/08/10-technical-papers-every-programmer-should-read-at-least-twice/
- http://canonical.org/~kragen/memory-models/
- formal verification: https://www.sciencedirect.com/science/article/pii/S0304397599002753
- do a proper bibliography, instead of just providing links to papers!
- there are some nice references in [Vorobyov], check them out!
    - D EUTSCH , A.: Static verification of dynamic properties. for example
- "Software Foundations" books by Penn
    - https://softwarefoundations.cis.upenn.edu/current/index.html
- FIX page numbers in citations
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

# QUESTIONS
- wikipedia links? shall I include them?
- how to properly reference online content (articles, blog posts) ?
- what errors are NOT type errors?

# META
- Planned main themes
    - type systems in programming languages
    - static analysis, formal verification
    - building a programming language and a static analyzer
        - incrementally adding type system features to a toy language and examining the costs/benefits
    - building a type checker
        - maybe try it for HCL (Terraform)?
- convert markdown to other document types: https://pandoc.org/
- https://github.com/tompollard/phd_thesis_markdown
- `.bib` format documentation: http://bib-it.sourceforge.net/help/fieldsAndEntryTypes.php#article
- numbered references!
    - use numbers instead names throughout the text (find out how to do in pandoc)
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

> In general, the more there is static checking in the compiler, the less need there is for manual debugging.
>
> **TODO: fix citation!**
> http://www.cse.chalmers.se/edu/year/2015/course/DAT150/lectures/proglang-07.html

## Contracts
**TODO: read through this paper, check SO link**
    - https://pdfs.semanticscholar.org/653b/fc1c9ede840964f7a6f0bb1e13d77bf9d2da.pdf
    - https://stackoverflow.com/a/5965869/1772429
    - read the part on contracts in duffy-error-model again!

> ontracts begin where the type system leaves off. A type system allows you to encode attributes of variables using types.
> A type limits the expected range values that a variable might hold. A contract similarly checks the range of values
> that a variable holds. The difference? Types are proven at compile-time through rigorous and composable inductive rules [...]
> Contracts are proven at compile-time where possible and at runtime otherwise [...]
>
> [@duffy-error-model]

# Research motivation
google this !!: "Static vs. dynamic type systems: an empirical study about the relationship between type casts and development time pdf"
    - so many pdf results!

# Agda
http://learnyouanagda.liamoc.net/pages/introduction.html
