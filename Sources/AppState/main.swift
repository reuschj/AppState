let initialState: StateMap = [
    "name": "Justin Reusch",
    "city": nil,
    "age": 36,
    "height": 178.4,
    "musician": false,
    "otherCities": ["Austin", "Rockford", "Allendale"]
]
var state = LocalState(initialState: initialState)

let name: String = state.name
let city: String? = state.city
let age: Int = state.age
let height: Double = state.height
var musician: Bool = state.musician
let otherCities: [String] = state.otherCities

print("Name: \(name)")
print("Age: \(age) years old")
print("City: \(city ?? "Not specified")")
print("Height: \(height)\"")
print(musician ? "Is a musician" : "Isn't a musician")
if !otherCities.isEmpty {
    let lineLength = 15
    print(String(repeating: "-", count: lineLength))
    print("Other Cities:")
    let _ = otherCities.map { print($0) }
    print(String(repeating: "-", count: lineLength))
}

state.setState("bar", for: "foo")
state.setState(true, for: "musician")
state.setState(["bar": "baz", "baz": true])

let foo: String = state.foo ?? ""
let bar: String = state.bar ?? ""
let baz: Bool = state.baz

musician = state.musician

print("Foo: \(foo)")
print("Bar: \(bar)")
print("Baz: \(baz)")
print(musician ? "Is a musician" : "Isn't a musician")

print(state.type(of: "age") ?? "Can't determine type")

// To here

let subOfString: StateMapOf<String> = state.filterByType()
print(subOfString)

var state2 = LocalState(initialState: [
    "name": "Justin Reusch",
    "city": nil,
    "age": 36,
    "height": 178.4,
    "musician": false
    ])
var state3 = LocalState(initialState: [
    "name": "Justin Reusch",
    "city": nil,
    "age": 36,
    "height": 178.4,
    "musician": false
    ])
print("States are equal: \(state2 == state3)")
print("State 2 is greater than State 3: \(state2 > state3)")
print("State 2 is less than State 3: \(state2 < state3)")
print("State 2 is greater than or equal to State 3: \(state2 >= state3)")
print("State 2 is less than or equal to State 3: \(state2 <= state3)")
print(state.hashValue)
print(state2.hashValue)
print(state3.hashValue)
print("Removing:", state3.remove("age") ?? "Not removed")
print(state3)

var state4 = GlobalState(initialState: [
    "name": "Justin Reusch",
    "city": nil
    ])
var state5 = state4
var state6 = LocalState(initialState: [
    "name": "Justin Reusch",
    "city": nil
    ])
var state7 = state6
state4.setState("Rockford", for: "city")
state6.setState("Rockford", for: "city")

print("")

print("Class:")
print(String(repeating: "-", count: 20))
print("Original:", state4, "City:", state4.lookup("city") ?? "nil")
print("Copy:", state5, "City:", state5.lookup("city") ?? "nil")

print("")

print("Structure:")
print(String(repeating: "-", count: 20))
print("Original:", state6)
print("Copy:", state7)
