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
