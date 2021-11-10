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

    func testUpdate() {
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
}
