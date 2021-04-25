
# Queues

A queue is just a bunch of code blocks, lined or queued up, waiting for a thread to execute them.

Note. You don't really need to worry about threads in Swift. Only `queues`. The system takes care of providing/allocation threads to execture code off the queues

>> https://www.youtube.com/watch?v=uRLcV2Rvheg

## GCD Grand Central Dispatch

GCD The API responsible for managing your queues.

Responsability:

- Create a Queue.
- Put block of code on a queue.

Blocks of code waiting in a queue are held in a `closure`

Type of Queues

### Main Queue
The most inmportant one of all. The queue where all blocks of code that affect the UI must be run on. (Its a single thread)

```swift
DispatchQueue.main
```

### Backgournd Queues

Used to queue up any long-lived, non UI Tasks. Often running simultanously and in parallel with the main UI queue.

```swift
DispatchQueue.global(qos: QoS)
```

## QoS Priorities

### .userInteractive
Animations
### .userInitiated
Content load like an email
### .utility
Long task that doesnt have to block the user interaction (long file download)
### .background
Task that could be done on background, Like maintenance tasks or clean up. 

## Adding Code to Queue

### Synchronous
When a work item is executred synchronously with the sync method, the program waits until execturion finishes before the method call returns. (Blocks the user)

```swift
DispatchQueue.main.sync {}
```

### Asynchronous
When a work item is executred synchronously with the async method, the method call returns immediately.
```swift
DispatchQueue.global().async {}
```
