import XCTest

import FastlaneTests

var tests = [XCTestCaseEntry]()
tests += FastlaneTests.allTests()
XCTMain(tests)
