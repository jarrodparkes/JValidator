import XCTest
@testable import JValidator

// MARK: - CharacterSetRuleTests: XCTestCase

class CharacterSetRuleTests: XCTestCase {

    static var allTests = [
        ("testCharacterSetRuleAlphaNumeric", testCharacterSetRuleAlphaNumeric),
        ("testCharacterSetRuleLettersOnly", testCharacterSetRuleLettersOnly),
        ("testCharacterSetRuleNumbersOnly", testCharacterSetRuleNumbersOnly),
        ("testCharacterSetRuleLowercaseLetters", testCharacterSetRuleLowercaseLetters),
        ("testCharacterSetRuleCustom", testCharacterSetRuleCustom),
    ]
    
    // MARK: Properties
    
    var rule: CharacterSetRule!

    // MARK: Tests

    func testCharacterSetRuleAlphaNumeric() {
        rule = CharacterSetRule.alphaNumeric
        XCTAssertNotNil(rule.validate("**1234"), "**1234 is not alpha numeric only")
        XCTAssertNotNil(rule.validate("1234abc%"), "1234abc% is not alpha numeric only")
        XCTAssertNil(rule.validate("123"), "123 is alpha numeric only")
        XCTAssertNil(rule.validate("123abc"), "123abc is alpha numeric only")
        XCTAssertNil(rule.validate("abc"), "abc is alpha numeric only")
    }

    func testCharacterSetRuleLettersOnly() {
        rule = CharacterSetRule.lettersOnly
        XCTAssertNotNil(rule.validate("$$"), "$$ does not have alpha only")
        XCTAssertNotNil(rule.validate("abc😎"), "abc😎 does not have alpha only")
        XCTAssertNotNil(rule.validate("-"), "- does not have alpha only")
        XCTAssertNotNil(rule.validate("021"), "021 does not have alpha only")
        XCTAssertNil(rule.validate("jarrod"), "jarrod is alpha only")
        XCTAssertNil(rule.validate("Aza"), "Aza is alpha only")
        XCTAssertNil(rule.validate("ZZTOP"), "ZZTOP is alpha only")
    }

    func testCharacterSetRuleNumbersOnly() {
        rule = CharacterSetRule.numbersOnly
        XCTAssertNotNil(rule.validate("$$"), "$$ does not have digits only")
        XCTAssertNotNil(rule.validate("abc😎"), "abc😎 does not have digits only")
        XCTAssertNotNil(rule.validate("-"), "- does not have digits only")
        XCTAssertNotNil(rule.validate("jarrod"), "jarrod does not have digits only")
        XCTAssertNil(rule.validate("021"), "021 has digits only")
        XCTAssertNil(rule.validate("123"), "123 has digits only")
    }

    func testCharacterSetRuleLowercaseLetters() {
        rule = CharacterSetRule(in: .lowercaseLetters)
        XCTAssertNotNil(rule.validate("$$"), "$$ is not lowercase letters only")
        XCTAssertNotNil(rule.validate("abc😎"), "abc😎 is not lowercase letters only")
        XCTAssertNotNil(rule.validate("-"), "- is not lowercase letters only")
        XCTAssertNotNil(rule.validate("012"), "012 is not lowercase letters only")
        XCTAssertNotNil(rule.validate("Aza"), "Aza is not lowercase letters only")
        XCTAssertNotNil(rule.validate("ZZTOP"), "ZZTOP is not lowercase letters only")
        XCTAssertNil(rule.validate("jarrod"), "jarrod is lowercase letters only")
    }

    func testCharacterSetRuleCustom() {
        rule = CharacterSetRule(in: CharacterSet(charactersIn: "test"))
        XCTAssertNotNil(rule.validate("$$"), "$$ has values not in `test`")
        XCTAssertNotNil(rule.validate("abc😎"), "abc😎 has values not in `test`")
        XCTAssertNotNil(rule.validate("-"), "- has values not in `test`")
        XCTAssertNotNil(rule.validate("021"), "021 has values not in `test`")
        XCTAssertNotNil(rule.validate("testy"), "ZZTOP has values not in `test`")
        XCTAssertNil(rule.validate("test"), "test only has values in set `test`")
        XCTAssertNil(rule.validate("testtest"), "testtest only has values in set `test`")
    }
}
