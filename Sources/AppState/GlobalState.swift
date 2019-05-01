import Foundation

// GlobalState
// ------------------------------------------------

/**
 This is an implemenation of `ApplicationState` as a `class`. This means it stores your state as a reference type (instead of a value type). So, when you copy your state from one variable to another, each copy will still point to the same place in memory. This is likely preferred when setting a state for an entire app, allowing different parts of the app to share a single instance.
 
 # Example
 ```
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
 - Author: Justin Reusch
 - Date: April 18, 2019
 */
public class GlobalState: ApplicationState {
    
    public var dateCreated = Date()
    
    public var stateMap: StateMap = [:]
    
    public required init() {
        self.stateMap = [:]
    }
    
}
