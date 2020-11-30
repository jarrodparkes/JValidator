import XCTest
@testable import JValidator

// MARK: - NoEmojiRuleTests: XCTestCase

class NoEmojiRuleTests: XCTestCase {

    static var allTests = [
        ("testRegexRule", testRegexRule),
    ]
    
    // MARK: Properties

    var rule: NoEmojiRule!

    // MARK: Tests

    func testRegexRule() {
        rule = NoEmojiRule()
        XCTAssertNotNil(rule.validate("😇"), "zz contains emoji")
        XCTAssertNotNil(rule.validate("lalala... 😴"), "AA contains emoji")
        XCTAssertNil(rule.validate("HI"), "HI doesn't contain any emoji")
        XCTAssertNil(rule.validate("WY"), "WY doesn't contain any emoji")
    }
}
