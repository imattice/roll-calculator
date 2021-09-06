//
//  RollLog.swift
//  roll-calculator
//
//  Created by Ike Mattice on 9/2/21.
//

import Foundation

///An object holding records of rolls for the current session
struct RollLog {
    ///A shared instance of the app's roll log
    static let shared = RollLog()
    ///The calculations recorded for the curernt session
    var calculations: [Calculation] = [Calculation]()
    ///Add a new calculation to the calculation history
    mutating func addCalculation(_ calc: Calculation) {
        calculations.append(calc)
    }
}
