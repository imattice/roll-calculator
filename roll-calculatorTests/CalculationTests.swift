//
//  CalculationTests.swift
//  roll-calculatorTests
//
//  Created by Ike Mattice on 9/2/21.
//

import XCTest

@testable import roll_calculator

class CalculationTests: XCTestCase {
    func testBasicCalculation() {
        let calculations: [(calculation: Calculation, result: Int)] = [
            (Calculation(method: "1+1"), 2),
            (Calculation(method: "1-1"), 0),
            (Calculation(method: "2*2"), 4),
            (Calculation(method: "9/3"), 3)
        ]

        calculations.forEach { test in
            let evaluation: Result<Int, CalculationError> = test.calculation.calculate()
            switch evaluation {
            case .success(let result):
                XCTAssertEqual(result, test.result, "Expected evaluation of '\(evaluation)' did not match expected result '\(test.result)'")

            case .failure(let error):
                XCTFail("Evaluation returned a failure with error: \(error)")
            }
        }
    }

    func testRollsReplaced() {
        let calculations: [(calculation: Calculation, maxStringLength: Int)] = [
            (Calculation(method: "1d4"), 1),
            (Calculation(method: "1+3d6"), 5),
            (Calculation(method: "1d4+3d6+100d100+4+7d20"), 16)
        ]

        calculations.forEach { test in
            let replacedString: String = test.calculation.rollsReplaced(test.calculation.method)

            XCTAssertTrue(replacedString.count <= test.maxStringLength, "'\(replacedString)' did not meet the expected length of \(test.maxStringLength)")
        }
    }

    func testUpdateWithDie() {
        let calculations: [(calculation: Calculation, update: ButtonValue, result: String)] = [
            (Calculation(), .die(value: 4), "1d4"),
            (Calculation(method: "1d6"), .die(value: 6), "2d6"),
            (Calculation(method: "(3d12) + "), .die(value: 12), "(3d12) + 1d12")
        ]

        calculations.forEach { testCase in
            testCase.calculation.update(testCase.update)

            XCTAssertEqual(testCase.calculation.method, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }

    func testUpdateWithNumeral() {
        let calculations: [(calculation: Calculation, update: ButtonValue, result: String)] = [
            (Calculation(), .numeral(value: 1), "1"),
            (Calculation(method: "6 + "), .numeral(value: 8), "6 + 8"),
            (Calculation(method: "1d4"), .numeral(value: 10), "1d4 + 10")
        ]

        calculations.forEach { testCase in
            testCase.calculation.update(testCase.update)

            XCTAssertEqual(testCase.calculation.method, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }

    func testUpdateWithOperand() {
        let calculations: [(calculation: Calculation, update: ButtonValue, result: String)] = [
            (Calculation(), .operand(value: .plus), ""),
            (Calculation(method: "6"), .operand(value: .multiply), "6 * "),
            (Calculation(method: "1 - "), .operand(value: .plus), "1 + ")
        ]

        calculations.forEach { testCase in
            testCase.calculation.update(testCase.update)

            XCTAssertEqual(testCase.calculation.method, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }
    func testUpdateWithParentheses() {
        let calculations: [(calculation: Calculation, update: ButtonValue, result: String)] = [
            (Calculation(), .parentheses(value: .opening), "( "),
            (Calculation(), .parentheses(value: .closing), "")
        ]

        calculations.forEach { testCase in
            testCase.calculation.update(testCase.update)

            XCTAssertEqual(testCase.calculation.method, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }

    func testBackspace() {
        let calculations: [(calculation: Calculation, update: ButtonValue, result: String)] = [
            (Calculation(), .backspace, ""),
            (Calculation(method: "1 + 1"), .backspace, "1 + "),
            (Calculation(method: "1 + "), .backspace, "1"),
            (Calculation(method: "( "), .backspace, ""),
            (Calculation(method: "14d100"), .backspace, ""),
            (Calculation(method: "7 + 1d4"), .backspace, "7 + "),
            (Calculation(method: "( 8 )"), .backspace, "( 8")
        ]

        calculations.forEach { testCase in
            testCase.calculation.update(testCase.update)

            XCTAssertEqual(testCase.calculation.method, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }

    func testClear() {
        let calculations: [(calculation: Calculation, update: ButtonValue, result: String)] = [
            (Calculation(), .clear, ""),
            (Calculation(method: "1 + 1"), .clear, ""),
            (Calculation(method: "1 + "), .clear, ""),
            (Calculation(method: "( "), .clear, ""),
            (Calculation(method: "7 + 1d4"), .clear, ""),
            (Calculation(method: "( 8 )"), .clear, "")
        ]

        calculations.forEach { testCase in
            testCase.calculation.update(testCase.update)

            XCTAssertEqual(testCase.calculation.method, testCase.result, "Calculation method was not updated with value \(testCase.update)")
        }
    }

    func testUpdateWithSequence() {
        let calculations: [(calculation: Calculation, updates: [ButtonValue], result: String)] = [
            (Calculation(),
             [
                .parentheses(value: .opening),
                .die(value: 4),
                .parentheses(value: .closing)
             ],
             "( 1d4 )")
        ]

        calculations.forEach { testCase in
            testCase.updates.forEach { update in
                testCase.calculation.update(update)
            }

            XCTAssertEqual(testCase.calculation.method,
                           testCase.result,
                           "Calculation method was not updated with sequence \(testCase.updates.description)")
        }
    }
}
