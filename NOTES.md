# Notes

## static vs class

static and class both associate a method with a class, rather than an instance of a class. The difference is that subclasses can override class methods; they cannot override static methods.

class properties will theoretically function in the same way (subclasses can override them), but they're not possible in Swift yet.
