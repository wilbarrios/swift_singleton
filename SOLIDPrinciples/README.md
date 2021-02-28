
# SOLID Principles on swift

In object-oriented computer programming, SOLID is a mnemonic acronym for five design principles intended to make software designs more understandable, flexible, and maintainable. [wikipedia](https://en.wikipedia.org/wiki/SOLID)

- The `S`ingle-reponsibility principle.
- The `O`pen-closed principle.
- The `L`iskov substitution principle.
- The `I`nterface segregation principle.
- The `D`ependency Inversion principle.

## The Single-responsibility principle:

A class should only have a single responsibility, that is, only changes to one part of the software's specification should be able to affect the specification of the class.

THERE SHOULD NEVER BE MORE THAN ONE REASON FOR A CLASS TO CHANGE.

## The Open-closed principle:

Software entities ... should be open for extension, but closed for modification.

If you want to create a class easy to maintain, it must have two important characteristics:

- Open for extension: You should be able to extend or change the behaviours of a class without efforts.
- Closed for modification: You must extend a class without changing the implementation.

## The Liskov substitution principle:

Objects in a program should be replaceable with instances of their subtypes without altering the correctness of that program.

FUNCTIONS THAT USE POINTERS OR REFERENCES TO BASE CLASSES MUST BE ABLE TO USE OBJECTS OF DERIVED CLASSES WITHOUT KNOWING IT.

## The Interface segregation principle:

Many client-specific interfaces are better than one general-purpose interface.

CLIENTS SHOULD NOT BE FORCED TO DEPEND UPON INTERFACES THAT THEY DO NOT USE.

## The Dependency Inversion principle:

Depend upon abstractions, [not] concretions.

A. HIGH LEVEL MODULES SHOULD NOT DEPEND UPON LOW LEVEL MODULES. BOTH SHOULD DEPEND UPON ABSTRACTIONS.

B. ABSTRACTIONS SHOULD NOT DEPEND UPON DETAILS. DETAILS SHOULD DEPEND UPON ABSTRACTIONS.

References:
- [SOLID Principles applied swift](https://marcosantadev.com/solid-principles-applied-swift/)
