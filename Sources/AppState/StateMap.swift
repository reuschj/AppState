import Foundation

// State Map Type Aliases
// ------------------------------------------------

/**
 A friendly type alias for a `Dictionary` containing state. Each member is accessed with a `String` key and holds an optional value of `Any` type (`nil` is allowed).
 
 `StateMap` is a `Dictionary` with types:
 - Key: `String`
 - Value: `Optional` of `Any` type
 
 # Example
 ```
 let foo: StateMap = ["name": "John", "age": 24]
 ```
 
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public typealias StateMap = [String: Any?]


/**
 A friendly type alias for a `StateMap` `Dictionary` of type `T`.
 
 `StateMapOf<T>` is a `Dictionary` with types:
 - Key: `String`
 - Value: Generic type `T`
 
 # Example
 ```
 let strings: StateMapOf<String> = ["name": "John", "city": "Cupertino"]
 let ints: StateMapOf<Int> = ["age": 24]
 ```
 
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public typealias StateMapOf<T> = [String: T]

/// Defines an open-ended dictionary for abstract use.
typealias AnyDictionary = [AnyHashable: Any]

/**
 This extends `StateMap` to allow values to be compared with the == operator. While `Dictionary` types are `Equatable` by default, `StateMap` is not because it stores `Any` type (which is not `Equatable`). This adds the == operator and an algorithm to determine equality.
 
 # Example
 ```
 let foo: StateMap = ["name": "John", "age": 24]
 let bar: StateMap = ["name": "John", "age": 24]
 print(foo == bar) // Prints "true"
 ```
 
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public extension Dictionary where Key == String, Value == Any? {
    // Allows StateMap values to be compared with the == operator
    static func == (lhs: StateMap, rhs: StateMap) -> Bool {
        guard lhs.count == rhs.count else { return false }
        guard lhs.keys == rhs.keys else { return false }
        let lhs = lhs as AnyDictionary
        let rhs = rhs as AnyDictionary
        return NSDictionary(dictionary: lhs).isEqual(to: rhs)
    }
}