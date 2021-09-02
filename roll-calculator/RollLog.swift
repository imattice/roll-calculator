//
//  RollLog.swift
//  roll-calculator
//
//  Created by Ike Mattice on 9/2/21.
//

import Foundation

struct RollLog {
    static let shared = RollLog()
    
    var calculations: [Calculation] = [Calculation]()
    
    mutating func addCalculation(_ calc: Calculation) {
        calculations.append(calc)
    }
}
