//
//  RollCalculatorUITests.swift
//  roll-calculatorUITests
//
//  Created by Ike Mattice on 8/21/21.
//

import XCTest

class RollCalculatorUITests: XCTestCase {
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
