import XCTest
@testable import JValidator

// MARK: - SetRuleTests: XCTestCase

class SetRuleTests: XCTestCase {

    static var allTests = [
        ("testSetRuleJoint", testSetRuleJoint),
        ("testSetRuleDisjoint", testSetRuleDisjoint),
    ]
    
    // MARK: Properties

    var rule: SetRule!

    // MARK: Tests

    func testSetRuleJoint() {
        rule = SetRule(in: ["ZZ", "YY"])
        XCTAssertNotNil(rule.validate("AK"), "AK is not in [`ZZ`, `YY`]")
        XCTAssertNotNil(rule.validate("SC"), "SC is not in [`ZZ`, `YY`]")
        XCTAssertNotNil(rule.validate("zz"), "zz is not in [`ZZ`, `YY`]")
        XCTAssertNotNil(rule.validate("YZ"), "YZ is not in [`ZZ`, `YY`]")
        XCTAssertNil(rule.validate("ZZ"), "ZZ is in [`ZZ`, `YY`]")
        XCTAssertNil(rule.validate("YY"), "YY is in [`ZZ`, `YY`]")
    }

    func testSetRuleDisjoint() {
        rule = SetRule(notIn: ["ZZ", "YY"])
        XCTAssertNotNil(rule.validate("ZZ"), "ZZ is in [`ZZ`, `YY`]")
        XCTAssertNotNil(rule.validate("YY"), "YY is in [`ZZ`, `YY`]")
        XCTAssertNil(rule.validate("AK"), "AK is not in [`ZZ`, `YY`]")
        XCTAssertNil(rule.validate("SC"), "SC is not in [`ZZ`, `YY`]")
        XCTAssertNil(rule.validate("zz"), "zz is not in [`ZZ`, `YY`]")
        XCTAssertNil(rule.validate("YZ"), "YZ is not in [`ZZ`, `YY`]")
    }
}
