
# Closures

Analyzing  this syntax `(([Sring]) -> Void) -> Void`

Why would you have to use this type? A closure as other closure parameters... The implementation is an alternative of using a `protocol`, but without all benefits that a protocol has.

Lets see both implementations.

## Closure aproach

```swift
import UIKit

typealias Item = String // We don't need any property for this example.
typealias ItemsLoader = (([Item]) -> Void) -> Void

class ItemsController: UIViewController {
    var loader: ItemsLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader {
            loadedItems in
            loadedItems.forEach( { print("\($0)\n") } )
        }
    }
}
```
This is how would look like the other side, the `ItemsLoader` implementation:

```swift
{ 
...
// Wherever composition function (i.e AppDelegate)
    let loader: FeedLoader = {
        load in
        let loadedItems: [Item] = makeItemsData() // Fetched from any datasource or created for testing pourposes
        load(loadedItems)
    }
    let controller = ItemsController()
    controller.loader = loader
    // ... present controller
}
```

## Protocol aproach

```swift
protocol ItemsLoader {
    typealias ItemsResponse = ([Item]) -> Void
    func load(completion: @escaping ItemsResponse)
}

class ItemsController: UIViewController {
    var loader: ItemsLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.load {
            loadedItems in
            loadedItems.forEach( { print("\($0)\n") } )
        }
    }
}
```

As you can see, is almost the exact same implementation, lets see the `loader` side:

```swift
class RemoteItemLoader: ItemsLoader {
    func load(completion: @escaping ItemsResponse) {
        let loadedItems: [Item] = makeItemsData() // Fetched from any datasource or created for testing pourposes
        completion(loadedItems)
    }
}
```

```swift
{ 
...
// Wherever composition function (i.e AppDelegate)
    let loader = RemoteItemLoader()
    let controller = ItemsController()
    controller.loader = loader
    // ... present controller
}
```

### Protocol benefits

* Extension
* More than one "action/function/feature"
