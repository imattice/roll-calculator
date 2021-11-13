//
//  CalculationMethodTests.swift
//  roll-calculatorTests
//
//  Created by Ike Mattice on 11/10/21.
//

import XCTest

@testable import roll_calculator

class CalculationMethodTests: XCTestCase {
    func testIsContainedInParenthesis() {
        let method: Calculation.Method = Calculation.Method(components: [
            .parentheses(value: .opening),
            .parentheses(value: .opening),
            .standardDie(roll: Roll(dieValue: 4)),
            .parentheses(value: .closing),
            .operand(value: .add),
            .numeral(value: 3),
            .parentheses(value: .closing),
            .operand(value: .subtract),
            .numeral(value: 6)
        ])

        XCTAssertTrue(method.isContainedInParentheses(componentIndex: 2),
                      "Expected \(method.components[2].displayString) to be in parentheses in method \(method.displayString)")
        XCTAssertTrue(method.isContainedInParentheses(componentIndex: 4),
                      "Expected \(method.components[4].displayString) to be in parentheses in method \(method.displayString)")
        XCTAssertFalse(method.isContainedInParentheses(componentIndex: 8),
                       "Expected \(method.components[8].displayString) to not be in parentheses in method \(method.displayString)")
    }

    func testUpdateWithDie() {
        let calculations: [(method: Calculation.Method, update: Calculation.Component, result: String)] = [
            (Calculation.Method(),
                .standardDie(roll: Roll(dieValue: 4)),
             "1d4"),

            (Calculation.Method(components: [
                .standardDie(roll: Roll(count: 1, dieValue: 6))
            ]),
             .standardDie(roll: Roll(dieValue: 6)),
             "2d6"),

            (Calculation.Method(components: [
                .standardDie(roll: Roll(count: 4, dieValue: 8))
            ]),
             .standardDie(roll: Roll(dieValue: 8)),
             "5d8"),

            (Calculation.Method(components: [
                .parentheses(value: .opening),
                .standardDie(roll: Roll(count: 3, dieValue: 12)),
                .parentheses(value: .closing),
                .operand(value: .add)
            ]),
             .standardDie(roll: Roll(dieValue: 12)),
             "( 3d12 ) + 1d12"),

            (Calculation.Method(components: [
                .parentheses(value: .opening),
                .parentheses(value: .opening),
                .standardDie(roll: Roll(count: 14, dieValue: 10)),
                .operand(value: .add),
                .numeral(value: 3),
                .parentheses(value: .closing),
                .operand(value: .add),
                .standardDie(roll: Roll(count: 6, dieValue: 10)),
                .parentheses(value: .closing),
                .operand(value: .add)
            ]),
             .standardDie(roll: Roll(dieValue: 10)),
             "( ( 14d10 + 3 ) + 6d10 ) + 1d10")
        ]

        calculations.forEach { testCase in
            testCase.method.update(with: testCase.update)

            XCTAssertEqual(testCase.method.displayString, testCase.result, "CalculationMethod was not updated with value \(testCase.update)")
        }
    }

    func testUpdateWithNumeral() {
        let calculations: [(method: Calculation.Method, update: Calculation.Component, result: String)] = [
            (method: Calculation.Method(),
             update: .numeral(value: 1),
             result: "1"),
            (method: Calculation.Method(components: [
                .numeral(value: 6),
                .operand(value: .add)
            ]),
             update: .numeral(value: 8),
             result: "6 + 8"),
            (method: Calculation.Method(components: [
                .standardDie(roll: Roll(dieValue: 4))
            ]),
             update: .numeral(value: 10),
             result: "1d4 + 10")
        ]

        calculations.forEach { testCase in
            testCase.method.update(with: testCase.update)

            XCTAssertEqual(testCase.method.displayString, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }

    func testUpdateWithOperand() {
        let calculations: [(method: Calculation.Method, update: Calculation.Component, result: String)] = [
            (method: Calculation.Method(),
             update: .operand(value: .add),
             result: ""),
            (method: Calculation.Method(components: [
                .numeral(value: 6)
            ]),
             update: .operand(value: .multiply),
             result: "6 *"),
            (method: Calculation.Method(components: [
                .numeral(value: 1),
                .operand(value: .subtract)
            ]),
             update: .operand(value: .add),
             result: "1 +")
        ]

        calculations.forEach { testCase in
            testCase.method.update(with: testCase.update)

            XCTAssertEqual(testCase.method.calculationString, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }
    func testUpdateWithParentheses() {
        let calculations: [(method: Calculation.Method, update: Calculation.Component, result: String)] = [
            (method: Calculation.Method(),
             update: .parentheses(value: .opening),
             result: "("),
            (method: Calculation.Method(),
             update: .parentheses(value: .closing),
             result: "")
        ]

        calculations.forEach { testCase in
            testCase.method.update(with: testCase.update)

            XCTAssertEqual(testCase.method.displayString, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }
    func testBackspace() {
        let calculations: [(method: Calculation.Method, result: String)] = [
            (method: Calculation.Method(),
             result: ""),
            (method: Calculation.Method(components: [
                .numeral(value: 1),
                .operand(value: .add),
                .numeral(value: 1)
            ]),
             result: "1 +"),
            (method: Calculation.Method(components: [
                .numeral(value: 1),
                .operand(value: .add)
            ]),
             result: "1"),
            (method: Calculation.Method(components: [
                .parentheses(value: .opening)
            ]),
             result: ""),
            (method: Calculation.Method(components: [
                .standardDie(roll: Roll(count: 14, dieValue: 100))
            ]),
             result: ""),
            (method: Calculation.Method(components: [
                .numeral(value: 7),
                .operand(value: .add),
                .standardDie(roll: Roll( dieValue: 4))
            ]),
             result: "7 +"),
            (method: Calculation.Method(components: [
                .parentheses(value: .opening),
                .numeral(value: 8),
                .parentheses(value: .closing)
            ]),
             result: "( 8")
        ]

        calculations.forEach { testCase in
            testCase.method.backspace()

            XCTAssertEqual(testCase.method.displayString, testCase.result, "Calculation method was not backspaced correctly")
        }
    }

    func testClear() {
        let calculations: [(method: Calculation.Method, result: String)] = [
            (method: Calculation.Method(),
             result: ""),
            (method: Calculation.Method(components: [
                .numeral(value: 1),
                .operand(value: .add),
                .numeral(value: 1)
            ]),
             result: ""),
            (method: Calculation.Method(components: [
                .numeral(value: 1),
                .operand(value: .add)
            ]),
             result: ""),
            (method: Calculation.Method(components: [
                .parentheses(value: .opening)
            ]),
             result: ""),
            (method: Calculation.Method(components: [
                .standardDie(roll: Roll(count: 14, dieValue: 100))
            ]),
             result: ""),
            (method: Calculation.Method(components: [
                .numeral(value: 7),
                .operand(value: .add),
                .standardDie(roll: Roll(count: 14, dieValue: 4))
            ]),
             result: ""),
            (method: Calculation.Method(components: [
                .parentheses(value: .opening),
                .numeral(value: 8),
                .parentheses(value: .closing)
            ]),
             result: "")
        ]

        calculations.forEach { testCase in
            testCase.method.clear()

            XCTAssertEqual(testCase.method.displayString, testCase.result, "Calculation method did not clear correctly")
        }
    }
}
