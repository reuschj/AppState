import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AppStateTests.allTests),
        testCase(GlobalStateTests.allTests),
        testCase(LocalStateTests.allTests)
    ]
}
#endif
