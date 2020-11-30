import XCTest
@testable import JValidator

// MARK: - RequiredRuleTests: XCTestCase

class RequiredRuleTests: XCTestCase {

    static var allTests = [
        ("testRequiredRule", testRequiredRule),
    ]
    
    // MARK: Properties

    var rule: RequiredRule!

    // MARK: Tests

    func testRequiredRule() {
        rule = RequiredRule()
        XCTAssertNotNil(rule.validate(""), "no value is provided")
        XCTAssertNil(rule.validate("value"), "value is provided")
    }
}
