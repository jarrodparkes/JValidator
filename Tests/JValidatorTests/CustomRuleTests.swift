import XCTest
@testable import JValidator

// MARK: - CustomRuleTests: XCTestCase

class CustomRuleTests: XCTestCase {

    static var allTests = [
        ("testValidNameRule", testValidNameRule),
    ]
    
    // MARK: Properties

    let validator = Validator.shared
    var rules: [Rule] = []
    
    // MARK: Tests

    func testValidNameRule() {
        let extrasSet = CharacterSet(charactersIn: "- '’.")
        let lettersAndExtras = CharacterSet.letters.union(extrasSet)

        rules = [CharacterSetRule(in: lettersAndExtras), NoEmojiRule()]
        XCTAssertNotNil(validator.validateString("123", withRules: rules), "123 is not a valid name")
        XCTAssertNotNil(validator.validateString("$$", withRules: rules), "$$ is not a valid name")
        XCTAssertNotNil(validator.validateString("abc😎", withRules: rules), "abc😎 is not a valid name")
        XCTAssertNil(validator.validateString("la-a", withRules: rules), "la-a is a valid name")
        XCTAssertNil(validator.validateString("jarrod", withRules: rules), "jarrod is a valid name")
        XCTAssertNil(validator.validateString("jarrod parkes", withRules: rules), "jarrod parkes is a valid name")
        XCTAssertNil(validator.validateString("-", withRules: rules), "- is a valid name... but not a good one")
        XCTAssertNil(validator.validateString("D'Angelo", withRules: rules), "D'Angelo is a valid name")
        XCTAssertNil(validator.validateString("D’Angelo", withRules: rules), "D’Angelo is a valid name")
        XCTAssertNil(validator.validateString("Adriana C. Ocampo Uria", withRules: rules), "Adriana C. Ocampo Uria is a valid name")
    }
}
