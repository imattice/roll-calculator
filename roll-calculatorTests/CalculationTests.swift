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
        let calculations: [(Calculation, result: Int)] = [
            (Calculation(method: "1+1"), result: 2),
            (Calculation(method: "1-1"), result: 0),
            (Calculation(method: "2*2"), result: 4),
            (Calculation(method: "9/3"), result: 3)
        ]

        calculations.forEach { test in
            let evaluation: Result<Int, CalculationError> = test.0.calculate()
            switch evaluation {
            case .success(let result):
                // swiftlint:disable line_length
                XCTAssertEqual(result, test.result, "Expected evaluation of '\(evaluation)' did not match expected result '\(test.result)'")
                // swiftlint:enable line_length

            case .failure(let error):
                XCTFail("Evaluation returned a failure with error: \(error)")
            }
        }
    }

    func testRollsReplaced() {
        let calculations: [(Calculation, maxStringLength: Int)] = [
            (Calculation(method: "1d4"), maxStringLength: 1),
            (Calculation(method: "1+3d6"), maxStringLength: 5),
            (Calculation(method: "1d4+3d6+100d100+4+7d20"), maxStringLength: 16)
        ]

        calculations.forEach { test in
            let replacedString: String = test.0.rollsReplaced(test.0.method)

            // swiftlint:disable line_length
            XCTAssertTrue(replacedString.count <= test.maxStringLength, "'\(replacedString)' did not meet the expected length of \(test.maxStringLength)")
            // swiftlint:enable line_length
        }
    }
}
