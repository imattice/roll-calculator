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
        let method: CalculationMethod = CalculationMethod(components: [
            .parentheses(value: .opening),
            .parentheses(value: .opening),
            .die(count: 1, value: 4),
            .parentheses(value: .closing),
            .operand(value: .plus),
            .numeral(value: 3),
            .parentheses(value: .closing),
            .operand(value: .minus),
            .numeral(value: 6)
        ])

        XCTAssertTrue(method.isContainedInParentheses(componentIndex: 2),
                      "Expected \(method.components[2].stringRepresentation) to be in parentheses in method \(method.displayString)")
        XCTAssertTrue(method.isContainedInParentheses(componentIndex: 4),
                      "Expected \(method.components[4].stringRepresentation) to be in parentheses in method \(method.displayString)")
        XCTAssertFalse(method.isContainedInParentheses(componentIndex: 8),
                       "Expected \(method.components[8].stringRepresentation) to not be in parentheses in method \(method.displayString)")
    }

    func testUpdateWithDie() {
        let calculations: [(method: CalculationMethod, update: CalculationComponent, result: String)] = [
            (CalculationMethod(), .die(value: 4), "1d4"),
            (CalculationMethod(components: [.die(count: 1, value: 6)]), .die(value: 6), "2d6"),
            (CalculationMethod(components: [.die(count: 4, value: 8)]), .die(value: 8), "5d8"),
            (CalculationMethod(components: [
                .parentheses(value: .opening),
                .die(count: 3, value: 12),
                .parentheses(value: .closing),
                .operand(value: .plus)
            ]),
             .die(value: 12),
             "( 3d12 ) + 1d12"),
            (CalculationMethod(components: [
                .parentheses(value: .opening),
                .parentheses(value: .opening),
                .die(count: 14, value: 10),
                .operand(value: .plus),
                .numeral(value: 3),
                .parentheses(value: .closing),
                .operand(value: .plus),
                .die(count: 6, value: 10),
                .parentheses(value: .closing),
                .operand(value: .plus)
            ]),
             .die(value: 10),
             "( ( 14d10 + 3 ) + 6d10 ) + 1d10")
        ]

        calculations.forEach { testCase in
            testCase.method.update(with: testCase.update)

            XCTAssertEqual(testCase.method.displayString, testCase.result, "CalculationMethod was not updated with value \(testCase.update)")
        }
    }
}
