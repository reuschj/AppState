import XCTest
@testable import AppState

final class LocalStateTests: XCTestCase {
    
    var testState: LocalState!
    
    override func setUp() {
        super.setUp()
        testState = LocalState(initialState: initialState)
    }
    
    func testThatEmptyInitializerWorks() {
        self.measure() {
            let testState = LocalState()
            let emptyStateMap: StateMap = [:]
            XCTAssert(testState.stateMap == emptyStateMap)
        }
    }
    
    func testThatInitializerWorksWithInitialState() {
        self.measure {
            let testState = LocalState(initialState: initialState)
            XCTAssert(testState.stateMap == initialState)
        }
    }
    
    func testThatStateValuesCanBeExtracted() {
        self.measure {
            let name: String = testState.name
            let city: String? = testState.city
            let age: Int = testState.age
            let height: Double = testState.height
            let signedIn: Bool = testState.signedIn
            let employeeList: [String] = testState.employeeList
            XCTAssert(name == initialName)
            XCTAssert(city == initialCity)
            XCTAssert(age == initialAge)
            XCTAssert(height == initialHeight)
            XCTAssert(signedIn == initialSignedInStatus)
            XCTAssert(employeeList == initialEmployeeList)
            XCTAssert(employeeList.count == 3)
            XCTAssert(initialCity ?? "no value" == "no value")
        }
    }
    
    func testThatSingleStateItemCanBeSet() {
        self.measure {
            let newCity = "Los Angeles"
            let newState = "California"
            testState.setState(newCity, for: "city")
            testState.setState(newState, for: "state")
            testState.setState(true, for: "signedIn")
            let city: String? = testState.city
            let state: String = testState.state
            let height: Double = testState.height
            let signedIn: Bool = testState.signedIn
            XCTAssert(city == newCity)
            XCTAssert(state == newState)
            XCTAssert(signedIn == true)
            XCTAssert(height == initialHeight)
            XCTAssert(city != initialCity)
            XCTAssert(signedIn != initialSignedInStatus)
        }
    }
    
    func testThatNewStateCanBeMergedWithState() {
        self.measure {
            let newStateDict: StateMap = ["city": "San Francisco", "recentlyMoved": true]
            testState.setState(newStateDict)
            let city: String? = testState.city
            let recentlyMoved: Bool = testState.recentlyMoved
            let height: Double = testState.height
            XCTAssert(city == "San Francisco")
            XCTAssert(recentlyMoved == true)
            XCTAssert(height == initialHeight)
            XCTAssert(city != initialCity)
        }
    }
    
    func testThatTypeCanBeQueried() {
        self.measure {
            XCTAssert(testState.type(of: "signedIn") == Bool.self)
        }
    }
    
    static var allTests = [
        ("testThatEmptyInitializerWorks", testThatEmptyInitializerWorks),
        ("testThatInitializerWorksWithInitialState", testThatInitializerWorksWithInitialState),
        ("testThatStateValuesCanBeExtracted", testThatStateValuesCanBeExtracted),
        ("testThatSingleStateItemCanBeSet", testThatSingleStateItemCanBeSet),
        ("testThatNewStateCanBeMergedWithState", testThatNewStateCanBeMergedWithState),
        ("testThatTypeCanBeQueried", testThatTypeCanBeQueried),
    ]
}
