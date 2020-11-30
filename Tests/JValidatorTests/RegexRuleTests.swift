import XCTest
@testable import JValidator

// MARK: - RegexRuleTests: XCTestCase

class RegexRuleTests: XCTestCase {

    static var allTests = [
        ("testRegexRuleDateStrings", testRegexRuleDateStrings),
        ("testRegexRuleEmail", testRegexRuleEmail),
        ("testRegexRulePassword", testRegexRulePassword),
        ("testRegexRulePhoneNumber", testRegexRulePhoneNumber),
        ("testRegexRuleSSN", testRegexRuleSSN),
        ("testRegexRuleZipCode", testRegexRuleZipCode),
        ("testRegexRuleCustom", testRegexRuleCustom),        
    ]
    
    // MARK: Properties

    var rule: RegexRule!

    // MARK: Tests

    func testRegexRuleDateStrings() {
        rule = RegexRule(regex: "^(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])(1|2)\\d\\d\\d$")
        XCTAssertNotNil(rule.validate("$$"), "$$ is not mmddyyyy format")
        XCTAssertNotNil(rule.validate("1234"), "1234 is not mmddyyyy format")
        XCTAssertNotNil(rule.validate("12020000"), "12020000 is mmddyyyy format, but yyyy must be (1|2)###")
        XCTAssertNil(rule.validate("11111111"), "11111111 is in mmddyyyy format")
        XCTAssertNil(rule.validate("12292012"), "12292012 is in mmddyyyy format")
    }

    func testRegexRuleEmail() {
        rule = RegexRule(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        XCTAssertNotNil(rule.validate("0️⃣.0️⃣"), "0️⃣.0️⃣ is not a valid email")
        XCTAssertNotNil(rule.validate("parkesfjarrodgmail.com"), "parkesfjarrodgmail.com is not a valid email")
        XCTAssertNotNil(rule.validate("@gmail.com"), "@gmail.com is not a valid email")
        XCTAssertNotNil(rule.validate("parkesfjarrod@"), "parkesfjarrod@ is not a valid email")
        XCTAssertNotNil(rule.validate("parkesfjarrod@gmail.c"), "parkesfjarrod@gmail.c is not a valid email")
        XCTAssertNil(rule.validate("parkesfjarrod@gmail.com"), "parkesfjarrod@gmail.com is a valid email")
        XCTAssertNil(rule.validate("jarrod.parkes@spurjobs.com"), "jarrod.parkes@spurjobs.com is a valid email")
    }

    func testRegexRulePassword() {
        rule = RegexRule(regex: ".{8,}$")
        XCTAssertNotNil(rule.validate("123"), "123 is not a valid new password")
        XCTAssertNotNil(rule.validate("12345"), "12345 is not a valid new password")
        XCTAssertNotNil(rule.validate("123456"), "12345 is not a valid new password")
        XCTAssertNotNil(rule.validate("😎😎😎😎😎😎"), "😎😎😎😎😎😎 is a valid new password")
        XCTAssertNil(rule.validate("password"), "password is a valid new password")
        XCTAssertNil(rule.validate("12345678"), "12345678 is a valid new password")
    }

    func testRegexRulePhoneNumber() {
        rule = RegexRule(regex: "^\\d{10}$")
        XCTAssertNotNil(rule.validate("566792467"), "566792467 is not a valid phone number")
        XCTAssertNotNil(rule.validate("1234"), "1234 is not a valid phone number")
        XCTAssertNotNil(rule.validate("12345-66"), "12345-66 is not a valid phone number")
        XCTAssertNil(rule.validate("2566792467"), "2566792467 is a valid phone number")
        XCTAssertNil(rule.validate("1234567890"), "1234567890 is a valid phone number")
    }

    func testRegexRuleSSN() {
        rule = RegexRule(regex: "^\\d{9}$")
        XCTAssertNil(rule.validate("566792467"), "566792467 is a valid SSN")
        XCTAssertNil(rule.validate("111111111"), "111111111 is a valid SSN")
        XCTAssertNotNil(rule.validate("1234"), "1234 is not a valid SSN")

        // rion.io/2013/09/10/validating-social-security-numbers-through-regular-expressions-2/
        rule = RegexRule(regex: "^(?!219099999|078051120)(?!666|000|9\\d{2})\\d{3}(?!00)\\d{2}(?!0{4})\\d{4}$")
        XCTAssertNil(rule.validate("566792467"), "566-79-2467 is a valid SSN")
        XCTAssertNil(rule.validate("111111111"), "111-11-1111 is a valid SSN")
        XCTAssertNotNil(rule.validate("00009999"), "000-09-999 is not a valid SSN")
        XCTAssertNotNil(rule.validate("66609999"), "666-09-999 is not a valid SSN")
        XCTAssertNotNil(rule.validate("99909999"), "999-09-999 is not a valid SSN")
        XCTAssertNotNil(rule.validate("21909999"), "219-09-999 is not a valid SSN")
        XCTAssertNotNil(rule.validate("078051120"), "078-05-1120 is not a valid SSN")
        XCTAssertNotNil(rule.validate("078001120"), "078-00-1120 is not a valid SSN")
        XCTAssertNotNil(rule.validate("111110000"), "111-11-0000 is not a valid SSN")
    }

    func testRegexRuleZipCode() {
        rule = RegexRule(regex: "\\d{5}(\\d{4})?")
        XCTAssertNotNil(rule.validate("$$"), "$$ is not a valid zip code")
        XCTAssertNotNil(rule.validate("1234"), "1234 is not a valid zip code")
        XCTAssertNotNil(rule.validate("1234566"), "12345-66 is not a valid zip code")
        XCTAssertNil(rule.validate("12345"), "12345 is a valid zip code")
        XCTAssertNil(rule.validate("123456789"), "12345-6789 is a valid zip code")
        XCTAssertNil(rule.validate("35801"), "35801 is a valid zip code")
    }

    func testRegexRuleCustom() {
        rule = RegexRule(regex: "^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$") // hex color
        XCTAssertNotNil(rule.validate("#abcdeff"), "#abcdeff is not a hex color")
        XCTAssertNotNil(rule.validate("#ZZZ"), "#ZZZ is not a hex color")
        XCTAssertNotNil(rule.validate("#1"), "#1 is not a hex color")
        XCTAssertNil(rule.validate("#222"), "#222 is a hex color")
        XCTAssertNil(rule.validate("#111111"), "#111111 is a hex color")
        XCTAssertNil(rule.validate("#FF7A87"), "#FF7A87 is a hex color")
        XCTAssertNil(rule.validate("#FF7A87"), "#ff7a87 is a hex color")
    }
}
