import XCTest
@testable import JValidator

// MARK: - DateRuleTests: XCTestCase

class DateRuleTests: XCTestCase {

    static var allTests = [
        ("testDateRule", testDateRule),
    ]
    
    // MARK: Properties

    var rule: DateRule!

    // MARK: Tests

    func testDateRule() {
        rule = DateRule(dateFormat: "MMddyyyy")
        XCTAssertNotNil(rule.validate("0️⃣.0️⃣"), "0️⃣.0️⃣ is not a date")
        XCTAssertNotNil(rule.validate("string"), "string is not a date")
        XCTAssertNil(rule.validate("06191990"), "06/19/1990 is a date")
        XCTAssertNil(rule.validate("09151990"), "09/15/1990 is a date")
        XCTAssertNil(rule.validate("09161990"), "09/16/1990 is a date")
    }
}
