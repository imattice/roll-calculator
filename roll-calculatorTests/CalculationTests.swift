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
        let calculations = [
            (Calculation(method: "1+1"), result: 2),
            (Calculation(method: "1-1"), result: 0),
            (Calculation(method: "2*2"), result: 4),
            (Calculation(method: "9/3"), result: 3)
        ]
        
        calculations.forEach { test in
            let evaluation = test.0.calculate()
            switch evaluation {
            case .success(let result):
                XCTAssertEqual(result, test.result, "Expected evaluation of '\(evaluation)' did not match expected result '\(test.result)'")
            case .failure(let error):
                XCTFail("Evaluation returned a failure with error: \(error)")
            }
        }
        
    }
}
