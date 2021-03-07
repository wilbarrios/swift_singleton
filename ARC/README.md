# Automatic Reference Counting (ARC)

Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage. In most cases, this means that memory management “just works” in Swift, and you don’t need to think about memory management yourself. ARC automatically frees up the memory used by class instances when those instances are no longer needed.

However, in a few cases ARC **requires** more information about the *relationships between parts of your code* in order to manage memory for you. 

Reference counting applies only to instances of classes. Structures and enumerations are value types, not reference types, and aren’t stored and passed by reference.
[The Swift Programing Language](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html)

Automatic Reference Counting (ARC) is a compiler feature that provides automatic memory management of Objective-C objects. Rather than having to **think about retain and release operations**, ARC allows you to concentrate on the interesting code, the object graphs, and the relationships between objects in your application. [Documentation Archive (Developer)](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)

## Thoughts

- Eventy time an instance has a new `strong reference` the ARC incremets the count by 1, this is used for free (or not) the space in memory used by an instance. 

### Instance space in memory
> Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance. This memory holds information about the type of the instance, together with the values of any stored properties associated with that instance.
To make sure that instances don’t disappear while they’re still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and doesn’t allow it to be deallocated for as long as that strong reference remains.

### Solving "Strong Reference Cycles"

Swift provides two ways to resolve strong reference cycles when you work with properties of class type: weak references and unowned references.
