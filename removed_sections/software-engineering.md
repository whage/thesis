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

