# Singletons

This repository is used settel ideas, notes, tests, examples and toughts of singletons on swift language. 

## Settings

MacOS Framework, with Xcode 12.2

### What is a singleton?

Is a software design pattern that restricts the instantiation of a class to one "single" instance. [wikipedia](https://en.wikipedia.org/wiki/Singleton_pattern)

Is a way to make sure that a calss has only one instance and it provides a single point of access to it. The pattern specifies that the class should be responsible itself for keeping track of its sole instance. It can further ensure that no other instance can be created by intercepting requestes foor creating new objects and provide a way to access the sole instance. [Design Patterns, Elements of Reusable Object-Oriented Software]()

### What is a global state?

A global variable, is a variable with global scope, meaning that it is visible throughout the program, unless shadowed.

Interaction mechanisms with global variables are called global enviroment mechanisms. The global enviroment paradigm is contrasted with the local environment paradigm, where all variables are local with no shared memory (and therefore all interactions can be reconducted to message passing).

#### Message Passing

Is a technique for invoking behavior (i.e., running a program) on a computer. the invoking program sends a message to a process (which may be an actor or object) and relies on that process and its supporting infrastructure to then select and run sume appropriate code. Message passing differs from conventional programming where a process, subroutine or function is directly invoked by name.
