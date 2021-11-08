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
            ("(1d4)", 4, "1d4"),
            ("2d4", 4, "2d4"),
            ("1 d4", 4, nil),
            ("600000d1000000", 10, nil),
            ("this contains a 5d7 roll", 7, "5d7"),
            ("This does not contain a roll", 10, nil),
            ("1 + (3d8) + 3", 8, "3d8")
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
}
