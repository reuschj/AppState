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

#### Example:
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

#### Example:
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

#### Example:
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

### setState(_:for:allowOverride:)

Sets a single value to type `T` to the specified member.
- Parameter `value`: The value you are storing to state
- Parameter `member`: The `String` key where you are storing the value to
- Parameter `allowOverride`: Allows opt-in or opt-out of overriding existing values
- Returns: Returns the orignal value as an optional (`nil` if member doesn't already exist)

#### Example:
```swift
var user = LocalState(initialState: ["name": nil]})
user.setState("Bob Johnson", for: "name") // Implementation has made allowOverride true by default
let name: String? = user.name
print(name ?? "No name") // Prints "Bob Johnson"
```

### setState(_:allowOverride:)

Set multiple members at once by passing a `StateMap` `Dictionary` to merge to state.
- Parameter `stateToMerge`: A `StateMap` `Dictionary` to merge into your state
- Parameter `allowOverride`: Allows opt-in or opt-out of overriding existing values
- Returns: Returns the original state before merge

#### Example:
```swift
var user = LocalState(initialState: ["name": nil]})
user.setState(["name": "Bob Johnson", "age": 42]) // Implementation has made allowOverride true by default
let name: String? = user.name
let age: Int? = user.age
print(name ?? "No name") // Prints "Bob Johnson"
print(age ?? "No age specified") // Prints "42"
```

### lookup<T>(_:)

Looks up the specified member from state and returns as an `Optional`.
- Parameter `member`: The `String` key where you are storing the value to
- Returns: Returns an `Optional` type (`.none` or `nil` if not found in state)

#### Example:
```swift
var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42])
let name: String? = user.lookup("name")
let age: Int? = user.lookup("age")
print(name ?? "No name") // Prints "Bob Johnson"
print(age ?? "No age specified") // Prints "42"
```

### lookup<T>(_:withDefault:)

Looks up the specified member from state and returns either the value or specified default value.
- Parameter `member`: The `String` key where you are storing the value to
- Parameter `defaultValue`: The default value to return if no value was found when looking up member.
- Returns: Returns a non-optional type and allows you to specify a default that will be used if the member is not found (or contains `nil`)

#### Example:
```swift
var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42])
let name: String = user.lookup("name", withDefault: "No name")
let age: Int = user.lookup("age", withDefault: 0)
print(name) // Prints "Bob Johnson"
print(age) // Prints "42"
```

### filterByType<T>()

Filters the `StateMap` by the given type `T`, returning a `Dictionary` with only members with value of type `T`.
- Returns: Returns a `Dictionary` with only members with value of type `T`

#### Example:
```swift
var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42, "state": "California", "numberOfCars": 1])
let strings: StateMapOf<String> = user.filterByType()
let ints: StateMapOf<Int> = user.filterByType()
print(strings) // Prints "["state": "California", "name": "Bob Johnson"]"
print(ints) // Prints "["age": 42, "numberOfCars": 1]"
```
### type(of:)

Gets the type of value stored in the given member.
- Parameter `member`: The `String` key where you are storing the value to
- Returns: The type of value stored in the given member

#### Example:
```swift
var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42, "signedIn": false])
print(user.type(of: "name") ?? "Member not found") // Prints "String"
print(user.type(of: "age") ?? "Member not found") // Prints "Int"
print(user.type(of: "signedIn") ?? "Member not found") // Prints "Bool"
```

### remove(_:)

Removes the given member from state.
- Returns: Returns the value that was removed

#### Example:
```swift
var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42, "state": "California", "numberOfCars": 1])
print("Removing:", user.remove("age") ?? "Not removed") // Prints "Removing: 42"
```

## Dynamic Members

Members of the state dictionary become dynamic members you can look up with dot notation by key. For example, if your state has a member with key "name":

```swift
var name: String = myState.name
```
This gets the value stored at key "name" and stores it to the `name` variable. Note that because the state can contain `Any` type of value, you will have to store values looked up to constants or variables like in the example above. This is what allows Swift to cast it from `Any` to the correct type. This means you can't just use it without storing:

```swift
// Can't do this:
print(myState.name)

// Can do this:
var name: String = myState.name
print(name)
```

If the member does not exist or cannot be cast to the declared type, a default value for your type will be used. Alternatively, you can declare as an optional type, in which case the value will be `nil` if non-existant or if the type cast fails:

```swift
var name: String? = myState.name
```

As-is, you can store and get any optional type like shown in the example above, even your own types. However, a non-optional type requires that a default value is provided. This package provides implementations for the basic Swift types: `String`, `Character`, `Int`, `Int8`, `UInt8`, `Int16`, `UInt16`, `Int32`, `UInt32`, `Int64`, `UInt64`, `Float`, `Double`, `Int32`, `Bool`, `Array`, `Set` and `Dictionary`. To change the default for any of these or add your own, just provide your own implementation with an `extension` to the `ApplicationState` protocol:

```swift
extension ApplicationState {
    // Changed default
    override subscript(dynamicMember member: String) -> String {
        return lookup(member, withDefault: "No value")
    }
    
    // Your own type
    override subscript(dynamicMember member: MyType) -> MyType {
        return lookup(member, withDefault: Type())
    }
}
```
