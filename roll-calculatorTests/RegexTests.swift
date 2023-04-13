//
//  RegexTests.swift
//  roll-calculatorTests
//
//  Created by Ike Mattice on 11/7/21.
//

import XCTest

@testable import roll_calculator

class RegexTests: XCTestCase {
    func testDieRollRegex() {
        let cases: [(test: String, result: String?)] = [
            ("1d4", "1d4"),
            ("1 d4", nil),
            ("600000d1000000", "600000d1000000"),
            ("this contains a 5d7 roll", "5d7"),
            ("This does not contain a roll", nil),
            ("(3d8) + 3", "3d8")
        ]

        cases.forEach { testCase in
            guard let matchRange: Range = testCase.test.range(
                of: Regex.dieRoll.pattern,
                options: [.regularExpression])
            else {
                XCTAssertNil(testCase.result)
                return
            }

            let matchString: String = String(testCase.test[matchRange])

            XCTAssertEqual(matchString, testCase.result)
        }
    }

    func testSpecificRollRegex() {
        let cases: [(test: String, dieValue: Int, result: String?)] = [
            ("1d4", 4, "1d4"),
            ("(1d4)", 4, "(1d4)"),
            ("2d4", 4, "2d4"),
            ("1 d4", 4, nil),
            ("600000d1000000", 10, nil),
            ("this contains a 5d7 roll", 7, "5d7"),
            ("This does not contain a roll", 10, nil),
            ("1 + (3d8) + 3", 8, "(3d8)")
        ]

        cases.forEach { testCase in
            guard let matchRange: Range = testCase.test.range(
                of: Regex.specificRoll(testCase.dieValue).pattern,
                options: [.regularExpression])
            else {
                XCTAssertNil(testCase.result)
                return
            }

            let matchString: String = String(testCase.test[matchRange])

            XCTAssertEqual(matchString, testCase.result)
        }
    }

    func testNumeric() {
        let cases: [(test: String, result: String?)] = [
            (test: "1", result: "1"),
            (test: "498", result: "498"),
            (test: "I have 3 dogs", result: "3"),
            (test: "zy8746ed-204ft", result: "8746"),
            (test: "NAN", result: nil)
        ]

        cases.forEach { testCase in
            guard let matchRange: Range = testCase.test.range(
                of: Regex.numeric.pattern,
                options: [.regularExpression])
            else {
                XCTAssertNil(testCase.result)
                return
            }

            let matchString: String = String(testCase.test[matchRange])

            XCTAssertEqual(matchString, testCase.result)
        }
    }

    func testOperand() {
        let cases: [(test: String, result: String?)] = [
            (test: "+", result: "+"),
            (test: "-", result: "-"),
            (test: "*", result: "*"),
            (test: "/", result: "/"),
            (test: "1+1", result: "+"),
            (test: ":-)", result: "-"),
            (test: "None", result: nil)
        ]

        cases.forEach { testCase in
            guard let matchRange: Range = testCase.test.range(
                of: Regex.operand.pattern,
                options: [.regularExpression])
            else {
                XCTAssertNil(testCase.result)
                return
            }

            let matchString: String = String(testCase.test[matchRange])

            XCTAssertEqual(matchString, testCase.result)
        }
    }

    func testParenthesis() {
        let cases: [(test: String, result: String?)] = [
            (test: "()", result: "("),
            (test: ":)", result: ")"),
            (test: "(1(9))", result: "("),
            (test: "None", result: nil)
        ]

        cases.forEach { testCase in
            guard let matchRange: Range = testCase.test.range(
                of: Regex.parenthesis.pattern,
                options: [.regularExpression])
            else {
                XCTAssertNil(testCase.result)
                return
            }

            let matchString: String = String(testCase.test[matchRange])

            XCTAssertEqual(matchString, testCase.result)
        }
    }
}
