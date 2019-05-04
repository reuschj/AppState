import XCTest

import GlobalStateTests
import LocalStateTests

var tests = [XCTestCaseEntry]()
tests += GlobalStateTests.allTests()
tests += LocalStateTests.allTests()
XCTMain(tests)
