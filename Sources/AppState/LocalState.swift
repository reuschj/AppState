import Foundation

// LocalState
// ------------------------------------------------

/**
 This is an implemenation of `ApplicationState` as a `struct`. This means it stores your state as a value type (instead of a reference type). So, when you copy your state from one variable to another, each copy will be updated independently. This is likely preferred when setting a state that applies to a component within the app. The value type provides more safety from unwanted mutation by different parts of the app.
 
 # Example
 ```
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
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public struct LocalState: ApplicationState {
    
    public var dateCreated = Date()

    public var state: StateMap = [:]
    
    public init() {
        self.state = [:]
    }
    
}
