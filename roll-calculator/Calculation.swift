//
//  Calculation.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/22/21.
//

import Foundation
import SwiftUI

/// An object that holds values used for a particular calculation
class Calculation: ObservableObject, Identifiable {
    /// A unique identifier for the calculation
    let id: String = UUID().uuidString
    /// The calculated result for the calculation
    @Published var result: String
    /// The method that creates a result
    @Published var method: String

    var description: String { "You rolled a \(result)!" }

    init(method: String = "", result: String = "") {
        self.result = result
        self.method = method
    }

    /// Calculate a new result for
    @discardableResult
    func calculate() -> Result<Int, CalculationError> {
        let rollsReplaced: String = rollsReplaced(method)
        let expression: NSExpression = NSExpression(format: rollsReplaced)

        guard let result = expression.expressionValue(with: nil, context: nil) as? Int else {
            return .failure(.invalidCalculation)
        }

        self.result = String(result)
        recordCalculation()

        method = rollsReplaced

        return .success(result)
    }

    /// Replaces the given die text with rolled values
    func rollsReplaced(_ text: String) -> String {
        guard let matchRange = text.range(of: Regex.dieRoll.pattern, options: [.regularExpression]) else {
            return text
        }

        guard var roll = try? Roll(fromString: String(text[matchRange])) else {
            return text
        }

        let result: Int = roll.calculate()
        let replacedText: String = text.replacingCharacters(in: matchRange, with: String(result))

        return rollsReplaced(replacedText)
    }

    /// Saves the calculation to the current RollLog
    func recordCalculation() {
//        RollLog.shared.addCalculation(self)
    }
}
