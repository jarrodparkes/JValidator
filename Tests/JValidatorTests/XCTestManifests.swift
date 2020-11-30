import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CharacterSetRuleTests.allTests),
        testCase(CustomRuleTests.allTests),
        testCase(DateRelationRuleTests.allTests),
        testCase(DateRuleTests.allTests),
        testCase(FloatRuleTests.allTests),
        testCase(LengthRuleTests.allTests),
        testCase(NoEmojiRuleTests.allTests),
        testCase(RegexRuleTests.allTests),
        testCase(RequiredRuleTests.allTests),
        testCase(SetRuleTests.allTests),
    ]
}
#endif
