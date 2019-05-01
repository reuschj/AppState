import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GlobalStateTests.allTests),
        testCase(LocalStateTests.allTests)
    ]
}
#endif
