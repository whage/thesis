### Python
Python features a dynamic type system. It is usually called a "strongly typed" language because even
though its type system doesn't enforce strict typing rules at compile type it is strict about what operations
are allowed on what types during run time and it will rarely do automatic type conversions.

The language is radically dynamic. Python's variables are just names that are bound to objects. They can be rebound any time during
execution and they always take on the type of the bound object, thus potentially changing their type.
This dynamic, loose type system is critical in Python's reputation as a language of quick, agile software development and prototyping.

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


Unified type system (maybe only for C#?): https://en.wikipedia.org/wiki/Comparison_of_C_Sharp_and_Java#Unified_type_system

#### Type erasure
**TODO: https://en.wikipedia.org/wiki/Generics_in_Java#Problems_with_type_erasure**

...

#### Other JVM-based languages
There are other languages, some quite popular that also use the JVM runtime but are wildly different from Java with
regards to their type systems.

- Groovy
- Scala

### Clojure, Racket (LISP family)
**TODO: look up some articles/papers on Clojure's type system and dynamic model**

**TODO: clojure vid: https://www.infoq.com/presentations/Clojure-The-Art-of-Abstraction/**

- also JVM based
- dynamic
- talk about some interesting TYPE SYSTEM features of LISPs

Lisp type system: https://lispcookbook.github.io/cl-cookbook/type.html

### Go
Developed by progamming language veterans at Google, GO features an interesting combination of stong static typing,
first class support for concurrency and an object oriented style built around composition instead of inheritance.

**TODO: https://thenewstack.io/understanding-golang-type-system/**

- there is no inheritance as in classical OOP! instead there is composition
- inheritance vs composition
	- https://stackoverflow.com/questions/49002/prefer-composition-over-inheritance
		- composition: changing behavior is possible at runtime (?)
	- https://www.javaworld.com/article/3409071/java-challenger-7-debugging-java-inheritance.html
- difficult at first because most of us is trained to think in a classical OOP way
- **TODO: benefits of Go's non-classical OOP model ?**

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

# Own research - type systems in programming languages

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

**TODO: write about MY experience with every language!**

### ML family - OCaml, Haskell, F#, Elm
The ML family of languages are the prominent representatives of the functional paradigm.
**TODO: 1-2 sentence about "functional"**
**TODO: Hindley-Milner - https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system**
**TODO: no exceptions seem to be needed in these languages. true? why?**

from [@abrahamson-quora]

**TODO: why are there no runtime errors? For which ML language is this true? Is it true for Elm? Why?**

#### Elm
**Elm's type system: https://elmprogramming.com/type-system.html**
**TODO: get inspired by Elm custom types: https://guide.elm-lang.org/types/custom_types.html**

**TODO: type and type alias differences**

- Elm tanulás közben jutott eszembe. Ott a típusok "üresnek tűnnek" (egyszerű "type" definíciókban csak neveket adunk meg, metódusok/függvények nem részei a típusdefiníciónak), és mégis sokrétűen lehet őket használni (generikusság, paraméterek)

**TODO: write about why it is hard to work with untyped data (JSON APIs) in Elm**
    some good thoughts: https://lispcast.com/clojure-and-types/#json-and-adts

#### Haskell

> Haskell was designed as a lingua franca for functional programming research and type theory research.
> It famously “avoids success at all costs” by sticking to its principles of purity and typeability.
> [@clojure-and-types]

#### My Elm experience
As a beginner Elm user, programming in the language feels very much like a fight, or rather an argument with the typechecker.
"I want this done here. No you can't do that, unless you do it that way there, there and there."
Everywhere the types need to match and even the slightest change can trigger an avalanche of type errors.
This can be a source of much frustration but as tiresome it may seem, the resulting software is remarkably bug free.
This is because the type system creates a solid underlying structure to the program.
At first sight the language seems hostile to the programmer, but as our code grows in complexity, the warnings of the type checker
become more and more valuable. We are not doing more work, we just do more of the work _before_ we ship our software.

...

Types in elm feel extremely lightweight. They are almost just labels on the underlying data. **TODO: revise, expand!**
https://medium.com/elm-shorts/an-intro-to-constructors-in-elm-57af7a72b11e

https://elmprogramming.com/type-system.html

- the compiler feels like a co-pilot that is constantly helping
	- it almost feels like pair programming
- it is the type system that makes it possible for the compiler to produce such helpful messages!

Ezen pedig gondolkodni, kifejteni:
```
type Result error value
    = Ok value
    | Err error

```
Itt error és value mintha típus paraméterek lennének, de úgy tudom, állhatna ott konkrét típus (vagy talán még value is?). Mikor mi? Mi a különbség az egyes esetek között? Ha ez a generikusság megfelelője Elm-ben, akkor ki kéne fejteni, hogy pl C#-ban hogy volt ez. Ott lehet mixelni típus paraméterrel konkrét típusokat?
C#: https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/constraints-on-type-parameters

https://package.elm-lang.org/packages/elm-lang/core/5.1.1/Json-Decode#map
> Note: If you run out of map functions, take a look at elm-decode-pipeline which makes it easier
to handle large objects, but produces lower quality type errors.

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

### Rust
Rust is a fairly young language that is rapidly gaining popularity. It aims to provide a modern alternative to low level,
high-performance but unsafe languages like C and C++ by promising memory safety.

**TODO about the above quote:**
- what is memory safety?
- how does one language generate more optimal machine code than the other?
- immutability
- etc

**TODO: writing unsafe programs in rust: (un)safety, subtyping, variance: https://doc.rust-lang.org/nomicon/**

https://github.com/doctorn/micro-mitten
> "Like Rust, micro-mitten offers a static approach to memory management"

**TODO: Option, Result types, "variants", "borrows", "lifetimes": https://fasterthanli.me/articles/a-half-hour-to-learn-rust**
**TODO: how do the above fit into the type system?**

...
