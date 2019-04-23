import XCTest
@testable import AppState

final class LocalStateTests: XCTestCase {
    
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
    
    static var allTests = [
        ("testThatEmptyInitializerWorks", testThatEmptyInitializerWorks),
        ("testThatInitializerWorksWithInitialState", testThatInitializerWorksWithInitialState),
    ]
}
