import Foundation

// ApplicationState
// ------------------------------------------------

/**
 This defines the requirements for an application state. An application state holds a dynamic `Dictionary` of `String` keys and optional values of `Any` type. `ApplicationState` is defined as a protocol to allow multiple implementations. It has been marked as public to allow you to create your own implementations, as needed. Two implementations are provided in this module.
 
 This module includes implemenations of `ApplicationState` as either a `struct` or `class`.
 ### As a Class (GlobalState):
 - Use the `GlobalState` `class`
 - An instance reference can be passed around without copying.
 - This is likely preferred when setting a state for an entire app, allowing different parts of the app to share a single instance.
 ### As a Structure (LocalState):
 - Use the `LocalState` `struct`
 - The value type can be copied and modified (without mutating the original).
 - This is likely preferred when setting a state that applies to a component within the app.
 - The value type provides more safety from unwanted mutation by different parts of the app.
 
 # Example
 ```
 struct MyState: ApplicationState {
    var dateCreated = Date()
    var state: StateMap = [:]
    init() {
        self.state = [:]
    }
 }
 ```
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
@dynamicMemberLookup
public protocol ApplicationState: Comparable, Hashable {
    
    // Initializers
    // --------------------------
    
    /// You must define what happens when initialized without parameters.
    init()
    
    /**
     Define what happens when initialized with an initial `StateMap` dictionary. A default implementation is automatically provided, but can be overriden by your custom implementation.
     - Parameter state: An initial value for your state.
     
     # Example
     ```
     let userInfo: StateMap = [
        "name": "John Smith",
        "age": 36,
        "signedIn": false
     ]
     var userState = LocalState(initialState: userInfo)
     ```
     - Author: Justin Reusch
     - Date: April 18, 2019
    */
    init(initialState state: StateMap)
    
    // Stored properties
    // --------------------------
    
    /// Stores a creation date for the state
    var dateCreated: Date { get }
    
    /// This stores the actual `StateMap` `Dictionary`. This state can be directly accessed using one of the required methods or by `@dynamicMemberLookup`.
    var stateMap: StateMap { get set }
    
    // Setting a value to state:
    // --------------------------
    
    /**
     Sets a single value to type `T` to the specified member.
     - Parameter value: The value you are storing to state
     - Parameter member: The `String` key where you are storing the value to
     - Parameter allowOverride: Allows opt-in or opt-out of overriding existing values
     - Returns: Returns the orignal value as an optional (`nil` if member doesn't already exist)
     
     # Example
     ```
     var user = LocalState(initialState: ["name": nil]})
     user.setState("Bob Johnson", for: "name") // Implementation has made allowOverride true by default
     let name: String? = user.name
     print(name ?? "No name") // Prints "Bob Johnson"
     ```
     
     - Author: Justin Reusch
     - Date: April 18, 2019
    */
    @discardableResult mutating func setState<T>(_ value: T, for member: String, allowOverride: Bool) -> T?
    
    /**
     Set multiple members at once by passing a `StateMap` `Dictionary` to merge to state.
     - Parameter stateToMerge: A `StateMap` `Dictionary` to merge into your state
     - Parameter allowOverride: Allows opt-in or opt-out of overriding existing values
     - Returns: Returns the original state before merge
     
     # Example
     ```
     var user = LocalState(initialState: ["name": nil]})
     user.setState(["name": "Bob Johnson", "age": 42]) // Implementation has made allowOverride true by default
     let name: String? = user.name
     let age: Int? = user.age
     print(name ?? "No name") // Prints "Bob Johnson"
     print(age ?? "No age specified") // Prints "42"
     ```
     
     - Author: Justin Reusch
     - Date: April 18, 2019
     */
    @discardableResult mutating func setState(_ stateToMerge: StateMap, allowOverride: Bool) -> StateMap
    
    // Looking up state members:
    // --------------------------
    
    /**
     Looks up the specified member from state and returns as an `Optional`.
     - Parameter member: The `String` key where you are storing the value to
     - Returns: Returns an `Optional` type (`.none` or `nil` if not found in state)
     
     # Example
     ```
     var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42])
     let name: String? = user.lookup("name")
     let age: Int? = user.lookup("age")
     print(name ?? "No name") // Prints "Bob Johnson"
     print(age ?? "No age specified") // Prints "42"
     ```
     
     - Author: Justin Reusch
     - Date: April 18, 2019
     */
    func lookup<T>(_ membmer: String) -> T?
    
    /**
     Looks up the specified member from state and returns either the value or specified default value.
     - Parameter member: The `String` key where you are storing the value to
     - Parameter defaultValue: The default value to return if no value was found when looking up member.
     - Returns: Returns a non-optional type and allows you to specify a default that will be used if the member is not found (or contains `nil`)
     
     # Example
     ```
     var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42])
     let name: String = user.lookup("name", withDefault: "No name")
     let age: Int = user.lookup("age", withDefault: 0)
     print(name) // Prints "Bob Johnson"
     print(age) // Prints "42"
     ```
     
     - Author: Justin Reusch
     - Date: April 18, 2019
     */
    func lookup<T>(_ member: String, withDefault defaultValue: T) -> T
    
    // Type methods:
    // --------------------------
    
    /**
     Filters the `StateMap` by the given type `T`, returning a `Dictionary` with only members with value of type `T`.
     - Returns: Returns a `Dictionary` with only members with value of type `T`
     
     # Example
     ```
     var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42, "state": "California", "numberOfCars": 1])
     let strings: StateMapOf<String> = user.filterByType()
     let ints: StateMapOf<Int> = user.filterByType()
     print(strings) // Prints "["state": "California", "name": "Bob Johnson"]"
     print(ints) // Prints "["age": 42, "numberOfCars": 1]"
     ```
     
     - Author: Justin Reusch
     - Date: April 18, 2019
     */
    func filterByType<T>() -> StateMapOf<T>
    
    /**
     Gets the type of value stored in the given member.
     - Parameter member: The `String` key where you are storing the value to
     - Returns: The type of value stored in the given member
     
     # Example
     ```
     var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42, "signedIn": false])
     print(user.type(of: "name") ?? "Member not found") // Prints "String"
     print(user.type(of: "age") ?? "Member not found") // Prints "Int"
     print(user.type(of: "signedIn") ?? "Member not found") // Prints "Bool"
     ```
     
     - Author: Justin Reusch
     - Date: April 18, 2019
     */
    func type(of member: String) -> Any.Type?
    
    // Removing from state:
    // --------------------------
    
    /**
     Removes the given member from state.
     - Returns: Returns the value that was removed
     
     # Example
     ```
     var user = LocalState(initialState: ["name": "Bob Johnson", "age": 42, "state": "California", "numberOfCars": 1])
     print("Removing:", user.remove("age") ?? "Not removed") // Prints "Removing: 42"
     ```
     
     - Author: Justin Reusch
     - Date: April 18, 2019
     */
    mutating func remove(_ member: String) -> Any?
    
    // Dynamic member subscripts:
    // --------------------------
    
    /**
     Gets member with value of type `T`, returning an optional value.
     - Parameter member: The `String` key where you are storing the value to
    */
    subscript<T>(dynamicMember member: String) -> T? { get }
    
    /**
     Gets member of a specific type. If no member if found, a default value is returned.
     - Parameter member: The `String` key where you are storing the value to
     
     Implementations are provided for the basic types. For your own types, or to add any additional types, extend `ApplicationState`.
     */
    // Strings and Characters
    subscript(dynamicMember member: String) -> String { get }
    subscript(dynamicMember member: String) -> Character { get }
    // Integer types
    subscript(dynamicMember member: String) -> Int { get }
    subscript(dynamicMember member: String) -> Int8 { get }
    subscript(dynamicMember member: String) -> UInt8 { get }
    subscript(dynamicMember member: String) -> Int16 { get }
    subscript(dynamicMember member: String) -> UInt16 { get }
    subscript(dynamicMember member: String) -> Int32 { get }
    subscript(dynamicMember member: String) -> UInt32 { get }
    subscript(dynamicMember member: String) -> Int64 { get }
    subscript(dynamicMember member: String) -> UInt64 { get }
    // Floating point types
    subscript(dynamicMember member: String) -> Float { get }
    subscript(dynamicMember member: String) -> Double { get }
    // Boolean
    subscript(dynamicMember member: String) -> Bool { get }
    // Collections
    subscript<T>(dynamicMember member: String) -> [T] { get }
    subscript<Key, Value>(dynamicMember member: String) -> [Key: Value] { get }
    subscript<T>(dynamicMember member: String) -> Set<T> { get }
    
}

/**
 Default implementations are provided for all required methods. These may be overriden with your custom implemenation as needed.
 */
public extension ApplicationState {
    
    // Initializers
    
    init(initialState state: StateMap = [:]) {
        self.init()
        self.stateMap = state
    }
    
    // Set state
    
    @discardableResult mutating func setState<T>(_ value: T, for member: String, allowOverride: Bool = true) -> T? {
        let originalValue: T? = lookup(member)
        let memberIsNew = originalValue == nil
        if allowOverride || memberIsNew {
            stateMap.updateValue(value, forKey: member)
        }
        return originalValue
    }
    
    @discardableResult mutating func setState(_ stateToMerge: StateMap, allowOverride: Bool = true) -> StateMap {
        let originalState: StateMap = stateMap
        let resolveMergeConflicts: (Any?, Any?) -> Any? = allowOverride ? { (_, new) in new } : { (current, _) in current }
        stateMap.merge(stateToMerge, uniquingKeysWith: resolveMergeConflicts)
        return originalState
    }
    
    // Lookup
    
    func lookup<T>(_ membmer: String) -> T? {
        return stateMap[membmer] as? T
    }
    
    func lookup<T>(_ member: String, withDefault defaultValue: T) -> T {
        return lookup(member) ?? defaultValue
    }
    
    // Type methods
    
    func filterByType<T>() -> StateMapOf<T> {
        return stateMap.filter { $0.value as? T != nil } as! StateMapOf<T>
    }
    
    func type(of member: String) -> Any.Type? {
        let possibleValue = stateMap[member] ?? nil
        guard let value = possibleValue else { return nil }
        return Swift.type(of: value)
    }
    
    // Removing members
    
    @discardableResult mutating func remove(_ member: String) -> Any? {
        return stateMap.removeValue(forKey: member) ?? nil
    }
    
    // Dynamic member lookup - All optionals
    
    subscript<T>(dynamicMember member: String) -> T? {
        return lookup(member)
    }
    
    // Dynamic member lookup - Specific types with defaults
    
    subscript(dynamicMember member: String) -> String {
        return lookup(member, withDefault: "")
    }
    
    subscript(dynamicMember member: String) -> Character {
        return lookup(member, withDefault: " ")
    }
    
    subscript<T: BinaryInteger>(dynamicMember member: String) -> T {
        return lookup(member, withDefault: 0)
    }
    
    subscript(dynamicMember member: String) -> Float {
        return lookup(member, withDefault: 0.0)
    }
    
    subscript(dynamicMember member: String) -> Double {
        return lookup(member, withDefault: 0.0)
    }
    
    subscript(dynamicMember member: String) -> Bool {
        return lookup(member, withDefault: false)
    }
    
    subscript<T>(dynamicMember member: String) -> [T] {
        return lookup(member, withDefault: [])
    }
    
    subscript<Key, Value>(dynamicMember member: String) -> [Key: Value] {
        return lookup(member, withDefault: [:])
    }
    
    subscript<T>(dynamicMember member: String) -> Set<T> {
        return lookup(member, withDefault: Set<T>())
    }
    
    // Makes Equatable (embedded state dictionaries must be equal)
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.stateMap == rhs.stateMap
    }
    
    // Makes Comparable (compares by count of state properties)
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.stateMap.count < rhs.stateMap.count
    }
    
    // Makes Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(dateCreated.hashValue)
        hasher.combine(stateMap.count)
    }
    
}
