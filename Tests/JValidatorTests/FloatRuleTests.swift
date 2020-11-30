import XCTest
@testable import JValidator

// MARK: - FloatRuleTests: XCTestCase

class FloatRuleTests: XCTestCase {

    static var allTests = [
        ("testFloatRule", testFloatRule),
    ]
    
    // MARK: Properties

    var rule: FloatRule!

    // MARK: Tests

    func testFloatRule() {
        rule = FloatRule()
        XCTAssertNotNil(rule.validate("0️⃣.0️⃣"), "0️⃣.0️⃣ is not a valid float")
        XCTAssertNotNil(rule.validate("string"), "string is not a valid float")
        XCTAssertNil(rule.validate("-0.001"), "-0.001 is a valid float")
        XCTAssertNil(rule.validate("0.001"), "0.001 is a valid float")
        XCTAssertNil(rule.validate("0.0"), "0.0 is a valid float")
        XCTAssertNil(rule.validate("12.12"), "12.12 is a valid float")
        XCTAssertNil(rule.validate("566792467"), "566792467 is a valid float")
        XCTAssertNil(rule.validate("12"), "12 is a valid float")
    }
}
