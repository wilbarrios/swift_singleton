# Notes

## static vs class

static and class both associate a method with a class, rather than an instance of a class. The difference is that subclasses can override class methods; they cannot override static methods.

class properties will theoretically function in the same way (subclasses can override them), but they're not possible in Swift yet.

### static let

In swift, an static let property is constant and lazy loaded, but, even is "lazy loaded" does not have access to instance properties or functions like an explicit `lazy` property.

```swift
class MyClass {
    private static let staticLet: OtherClass = {
        let c = OtherClass()
        c.otherClassProperty = self.instanceFunction() // Compiler error "Cannot find 'self' in scope"
        return c
    }()
    
    /// Lazy properties are `var` exclusive
    private lazy var lazyVar: OtherClass = {
        let c = OtherClass()
        c.otherClassProperty = self.instanceFunction() // Valid
        return c
    }()
    
    internal func instanceFunction() -> String {
        print("instanceFunction invoked")
        return "Value"
    }
}
```
