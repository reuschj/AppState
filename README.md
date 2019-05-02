# AppState

This package defines the requirements for an application state. An application state holds a dynamic `Dictionary` of `String` keys and optional values of `Any` type. 

`ApplicationState` is defined as a protocol to allow multiple implementations. It has been marked as public to allow you to create your own implementations, as needed. Two implementations are provided in this module.

This module includes implemenations of `ApplicationState` as either a `struct` or `class`:

### As a Class (GlobalState):
- Use the `GlobalState` `class`
- An instance reference can be passed around without copying.
- This is likely preferred when setting a state for an entire app, allowing different parts of the app to share a single instance.

### As a Structure (LocalState):
- Use the `LocalState` `struct`
- The value type can be copied and modified (without mutating the original).
- This is likely preferred when setting a state that applies to a component within the app.
- The value type provides more safety from unwanted mutation by different parts of the app.

### Example
```swift
struct MyState: ApplicationState {
    var dateCreated = Date()
    var state: StateMap = [:]
    init() {
        self.state = [:]
    }
}
```

## Global State
This is an implemenation of `ApplicationState` as a `class`. This means it stores your state as a reference type (instead of a value type). 

So, when you copy your state from one variable to another, each copy will still point to the same place in memory. This is likely preferred when setting a state for an entire app, allowing different parts of the app to share a single instance.

### Example
```swift
var user = GlobalState(initialState: [
    "name": "Mike Smith",
    "city": "Los Angeles"
])

var currentUser = user
currentUser.setState("Jane Appleseed", for: "name")
currentUser.setState("San Francisco", for: "city")
print("Original:", user.state) // Print "Original: ["name": Optional("Jane Appleseed"), "city": Optional("San Francisco")]"
print("Copy:", currentUser.state) // Prints "Copy: ["name": Optional("Jane Appleseed"), "city": Optional("San Francisco")]"
```
## Local State
This is an implemenation of `ApplicationState` as a `struct`. This means it stores your state as a value type (instead of a reference type). 

So, when you copy your state from one variable to another, each copy will be updated independently. This is likely preferred when setting a state that applies to a component within the app. The value type provides more safety from unwanted mutation by different parts of the app.

### Example
```swift
var user = LocalState(initialState: [
    "name": "Mike Smith",
    "city": "Los Angeles"
])

var user02 = user
user02.setState("Jane Appleseed", for: "name")
user02.setState("San Francisco", for: "city")
print("Original:", user.state) // Print "Original: ["name": Optional("Mike Smith"), "city": Optional("Los Angeles")]"
print("Copy:", user02.state) // Prints "Copy: ["name": Optional("Jane Appleseed"), "city": Optional("San Francisco")]"
```

## Methods

### `SetState(_:for)`

To be continued...


