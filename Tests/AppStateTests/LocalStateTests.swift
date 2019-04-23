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
            XCTAssert(testState.state == emptyStateMap)
        }
    }
    
    func testThatInitializerWorksWithInitialState() {
        self.measure {
            let testState = LocalState(initialState: initialState)
            XCTAssert(testState.state == initialState)
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
        }
    }
    
    static var allTests = [
        ("testThatEmptyInitializerWorks", testThatEmptyInitializerWorks),
        ("testThatInitializerWorksWithInitialState", testThatInitializerWorksWithInitialState),
        ("testThatStateValuesCanBeExtracted", testThatStateValuesCanBeExtracted),
    ]
}
