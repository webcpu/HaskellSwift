import XCTest

// Support building the "enumerated"-tests style, on OS X.
#if !os(Linux)
public protocol XCTestCaseProvider {
    var allTests : [(String, () -> ())] { get }
}
#endif
