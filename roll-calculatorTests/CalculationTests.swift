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
            (calculation:
                Calculation(
                    method: Calculation.Method(
                        components: [
                            .numeral(value: 1),
                            .operand(value: .add),
                            .numeral(value: 1)
                        ]
                    )
                ),
             result: 2),
            (calculation:
                Calculation(
                    method: Calculation.Method(
                        components: [
                            .numeral(value: 1),
                            .operand(value: .subtract),
                            .numeral(value: 1)
                        ]
                    )
                ),
             result: 0),
            (calculation:
                Calculation(
                    method: Calculation.Method(
                        components: [
                            .numeral(value: 2),
                            .operand(value: .multiply),
                            .numeral(value: 2)
                        ]
                    )
                ),
             result: 4),
            (calculation:
                Calculation(
                    method: Calculation.Method(
                        components: [
                            .numeral(value: 9),
                            .operand(value: .divide),
                            .numeral(value: 3)
                        ]
                    )
                ),
             result: 3)
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
        let calculations: [Calculation] = [
            Calculation(
                method: Calculation.Method(
                    components: [
                        .standardDie(roll: Roll( dieValue: 4))
                    ]
                )
            ),
            Calculation(
                method: Calculation.Method(
                    components: [
                        .numeral(value: 1),
                        .operand(value: .add),
                        .standardDie(roll: Roll(count: 3, dieValue: 6))
                    ]
                )
            ),
            Calculation(
                method: Calculation.Method(
                    components: [
                        .parentheses(value: .opening),
                        .standardDie(roll: Roll(dieValue: 4)),
                        .operand(value: .add),
                        .standardDie(roll: Roll(count: 3, dieValue: 6)),
                        .parentheses(value: .closing),
                        .operand(value: .add),
                        .standardDie(roll: Roll(count: 100, dieValue: 100)),
                        .operand(value: .add),
                        .standardDie(roll: Roll(count: 14, dieValue: 20))
                    ]
                )
            )
        ]

        calculations.forEach { test in
            let replacedString: String = test.rollsReplaced(test.method.displayString)

            XCTAssertFalse(replacedString.contains("d"), "'\(replacedString)' contained a 'd'")
        }
    }

    func testUpdateWithSequence() {
        let calculations: [(calculation: Calculation, updates: [Calculation.Component], result: String)] = [
            (Calculation(),
             [
                .parentheses(value: .opening),
                .standardDie(roll: Roll(dieValue: 4)),
                .parentheses(value: .closing)
             ],
             "( 1d4 )")
        ]

        calculations.forEach { testCase in
            testCase.updates.forEach { update in
                testCase.calculation.method.update(with: update)
            }

            XCTAssertEqual(testCase.calculation.method.displayString,
                           testCase.result,
                           "Calculation method was not updated with sequence \(testCase.updates.description)")
        }
    }
}
