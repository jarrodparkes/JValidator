import XCTest
@testable import JValidator

// MARK: - DateRelationRuleTests: XCTestCase {

class DateRelationRuleTests: XCTestCase {

    static var allTests = [
        ("testDateRelationWithDateInit", testDateRelationWithDateInit),
        ("testDateRelationRuleAfter", testDateRelationRuleAfter),
        ("testDateRelationRuleBefore", testDateRelationRuleBefore),
        ("testDateRelationRuleMaximumAge", testDateRelationRuleMaximumAge),
        ("testDateRelationRuleMinimumAge", testDateRelationRuleMinimumAge),
    ]
    
    // MARK: Properties

    var rule: DateRelationRule!

    // MARK: Tests

    func testDateRelationWithDateInit() {
        rule = DateRelationRule(before: Date(), dateFormat: "MMddyyyy", dateDisplayFormat: "MMddyyyy")
        XCTAssertNil(rule.validate("09171990"), "09/17/1990 is before today")
    }

    func testDateRelationRuleAfter() {
        rule = DateRelationRule(after: "09161990", dateFormat: "MMddyyyy", dateDisplayFormat: "MMddyyyy")
        XCTAssertNotNil(rule.validate("06191990"), "06/19/1990 is not after 09/16/1990")
        XCTAssertNotNil(rule.validate("09151990"), "09/15/1990 is not after 09/16/1990")
        XCTAssertNotNil(rule.validate("09161990"), "09/16/1990 is not after 09/16/1990")
        XCTAssertNil(rule.validate("09171990"), "09/17/1990 is after 09/16/1990")
        XCTAssertNil(rule.validate("09161991"), "09/16/1991 is after 09/16/1990")

        rule = DateRelationRule(afterOrEqualTo: "09161990", dateFormat: "MMddyyyy", dateDisplayFormat: "MMddyyyy")
        XCTAssertNotNil(rule.validate("09131990"), "09/13/1990 is not after or equal to 09/16/1990")
        XCTAssertNil(rule.validate("09161990"), "09/16/1990 is after or equal to 09/16/1990")
    }

    func testDateRelationRuleBefore() {
        rule = DateRelationRule(before: "09161990", dateFormat: "MMddyyyy", dateDisplayFormat: "MMddyyyy")
        XCTAssertNotNil(rule.validate("09171990"), "09/17/1990 is not before 09/16/1990")
        XCTAssertNotNil(rule.validate("09161991"), "09/16/1991 is not before 09/16/1990")
        XCTAssertNil(rule.validate("06191990"), "06/19/1990 is before 09/16/1990")
        XCTAssertNil(rule.validate("09151990"), "09/15/1990 is before 09/16/1990")

        rule = DateRelationRule(beforeOrEqualTo: "09161990", dateFormat: "MMddyyyy", dateDisplayFormat: "MMddyyyy")
        XCTAssertNotNil(rule.validate("09181990"), "09/18/1990 is not before or equal to 09/16/1990")
        XCTAssertNil(rule.validate("09161990"), "09/16/1990 is before or equal to 09/16/1990")
    }

    func testDateRelationRuleMaximumAge() {
        rule = DateRelationRule(maximumAge: 99, dateFormat: "MM/dd/yyyy", dateDisplayFormat: "MMddyyyy")

        var dateString = "\(month())/\(day())/\(year())"
        XCTAssertNil(rule.validate(dateString), "\(dateString) is younger than 99")

        dateString = "\(month())/\(day())/\(year(offsetBy: -99))"
        XCTAssertNil(rule.validate(dateString), "\(dateString) is 99")

        dateString = "\(month())/\(day())/\(year(offsetBy: -100))"
        XCTAssertNotNil(rule.validate(dateString), "\(dateString) is older than 99")
    }

    func testDateRelationRuleMinimumAge() {
        rule = DateRelationRule(minimumAge: 15, dateFormat: "MM/dd/yyyy", dateDisplayFormat: "MMddyyyy")

        var dateString = "\(month())/\(day())/\(year())"
        XCTAssertNotNil(rule.validate(dateString), "\(dateString) is younger than 15")

        dateString = "\(month())/\(day())/\(year(offsetBy: -15))"
        XCTAssertNil(rule.validate(dateString), "\(dateString) is 15")

        dateString = "\(month())/\(day())/\(year(offsetBy: -16))"
        XCTAssertNil(rule.validate(dateString), "\(dateString) is older than 15")
    }

    // MARK: Helpers

    func day(offsetBy offset: Int = 0) -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: offset, to: Date()) ?? Date()
        return "\(String(format: "%02d", calendar.component(.day, from: date)))"
    }

    func month(offsetBy offset: Int = 0) -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .month, value: offset, to: Date()) ?? Date()
        return "\(String(format: "%02d", calendar.component(.month, from: date)))"
    }

    func year(offsetBy offset: Int = 0) -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .year, value: offset, to: Date()) ?? Date()
        return "\(String(format: "%02d", calendar.component(.year, from: date)))"
    }
}
