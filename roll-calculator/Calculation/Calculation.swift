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
    @Published var result: Result?
    /// The method that creates a result
    @Published var method: Method

    init(method: Method = Method()) {
        self.method = method
    }

    init?(from string: String) {
        guard let method = Method(string: string) else {
            return nil
        }

        self.method = method
    }

    /// Calculate a new result for
    // Because of the addition of the Calculation.Result, any Swift.Result need to specify Swift module
    @discardableResult
    func evaluate() -> Swift.Result<Int, CalculationError> {
        method.cleanUp()

        // Roll the die
        let rollsReplaced: String = rollsReplaced(method.calculationString)

        // Prepare the string for calculation
        let calculationString: String = rollsReplaced
            .replacingOccurrences(of: "[", with: "(")
            .replacingOccurrences(of: "]", with: ")")

        // Calculate the string
        let expression: NSExpression = NSExpression(format: calculationString)
        guard let result = expression.expressionValue(with: nil, context: nil) as? Int else {
            return .failure(.invalidCalculation)
        }

        // Create and set the result
        let calculationResult: Result = Result(value: result, method: rollsReplaced)
        self.result = calculationResult

        recordCalculation()

        return .success(result)
    }

    /// Updates the calculation's method with the given component
    func updateMethod(with component: Component) {
        method.update(with: component)
    }

    /// Removes the last component from the calculation's method
    func backspace() {
        method.backspace()
    }

    /// Remove all components from the calculation's method
    func clear() {
        method.clear()
        result = nil
    }

    /// Replaces the given die text with rolled values
    func rollsReplaced(_ text: String) -> String {
        guard let matchRange = text.range(of: Regex.dieRoll.pattern, options: [.regularExpression]) else {
            return text
        }

        guard var roll = try? Roll(fromString: String(text[matchRange])) else {
            return rollsReplaced("\(0)")
        }

        roll.calculate()
        let rollResults: String = "[\(roll.results.map { String($0) }.joined(separator: " + "))]"
        let replacedText: String = text.replacingCharacters(in: matchRange, with: rollResults)

        return rollsReplaced(replacedText)
    }

    /// Saves the calculation to the current RollLog
    func recordCalculation() {
        // TODO: Implement method
    }
}
