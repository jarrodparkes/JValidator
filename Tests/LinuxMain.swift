import XCTest
import JValidatorTests

var tests = [XCTestCaseEntry]()
tests += CharacterSetRuleTests.allTests()
tests += CustomRuleTests.allTests()
tests += DateRelationRuleTests.allTests()
tests += DateRuleTests.allTests()
tests += FloatRuleTests.allTests()
tests += LengthRuleTests.allTests()
tests += NoEmojiRuleTests.allTests()
tests += RegexRuleTests.allTests()
tests += RequiredRuleTests.allTests()
tests += SetRuleTests.allTests()
XCTMain(tests)
