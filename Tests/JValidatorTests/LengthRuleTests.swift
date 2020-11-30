import XCTest
@testable import JValidator

// MARK: - LengthRuleTests: XCTestCase

class LengthRuleTests: XCTestCase {

    static var allTests = [
        ("testLengthRuleExact", testLengthRuleExact),
        ("testLengthRuleLessThan", testLengthRuleLessThan),
        ("testLengthRuleGreaterThan", testLengthRuleGreaterThan),
    ]
    
    // MARK: Properties

    var rule: LengthRule!

    // MARK: Tests

    func testLengthRuleExact() {
        rule = LengthRule(equalTo: 2)
        XCTAssertNotNil(rule.validate("566792467"), "566792467 is not equal to 2 characters")
        XCTAssertNotNil(rule.validate("1"), "1 is not equal to 2 characters")
        XCTAssertNil(rule.validate("12"), "12 is equal to 2 characters")

        rule = LengthRule(equalTo: 4)
        XCTAssertNotNil(rule.validate("2566792467"), "2566792467 is not equal to 4 characters")
        XCTAssertNotNil(rule.validate("12"), "12 is not equal to 4 characters")
        XCTAssertNil(rule.validate("1111"), "1111 is equal to 4 characters")
    }

    func testLengthRuleLessThan() {
        rule = LengthRule(lessThan: 2)
        XCTAssertNotNil(rule.validate("566792467"), "566792467 is not less than 2 characters")
        XCTAssertNil(rule.validate("1"), "1 is less than 2 characters")

        rule = LengthRule(lessThan: 4)
        XCTAssertNotNil(rule.validate("2566792467"), "2566792467 is not less than 4 characters")
        XCTAssertNil(rule.validate("1"), "1 is less than 4 characters")

        rule = LengthRule(lessThanOrEqualTo: 2)
        XCTAssertNil(rule.validate("12"), "12 is equal to 2 characters")
    }

    func testLengthRuleGreaterThan() {
        rule = LengthRule(greaterThan: 2)
        XCTAssertNotNil(rule.validate("1"), "1 is not more than 2 characters")
        XCTAssertNil(rule.validate("566792467"), "566792467 is more than 2 characters")

        rule = LengthRule(greaterThan: 4)
        XCTAssertNotNil(rule.validate("1"), "1 is not more than 4 characters")
        XCTAssertNil(rule.validate("2566792467"), "2566792467 is more than 4 characters")

        rule = LengthRule(greaterThanOrEqualTo: 2)
        XCTAssertNil(rule.validate("12"), "12 is equal to 2 characters")
    }
}
