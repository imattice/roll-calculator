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
        // TODO: Implement method
    }

    /// Removes user input errors from the current method
    private func validateMethod() {
        var processedMethod: String = method
        // Method should not begin or end with whitespace
        processedMethod = processedMethod.trimmingCharacters(in: .whitespacesAndNewlines)

        // Method should not end with an Operand
        if let lastCharacter: String.Element = processedMethod.last,
           Operand.symbolStrings.contains(String(lastCharacter)) {
            processedMethod.removeLast()
        }
    }

    /// Removes operands from the end of the current method
    private func removeTrailingOperands(from string: String) -> String {
        var processedString: String = string
        if let lastCharacter: String.Element = string.last,
           Operand.symbolStrings.contains(String(lastCharacter)) {
            processedString.removeLast()
            processedString = processedString.trimmingCharacters(in: .whitespacesAndNewlines)

            return removeTrailingOperands(from: processedString)
        }

        return processedString
    }
}

// MARK: - Method
extension Calculation {
    class Method {
        @Published var components: [Calculation.Component]

        var displayString: String {
            components.map { $0.displayString }.joined(separator: " ")
        }

        init(components: [Calculation.Component] = [Calculation.Component]()) {
            self.components = components
        }

        func update(with component: Calculation.Component) {
            // Combine any existing standard die not in parenthesis
            /* swiftlint:disable explicit_type_interface */
            // check that the entered component is a die roll
            if case .standardDie(let inputCount, let inputValue) = component,
               // check if there is a match in the components
               let matchIndex: Int = components.indexForSpecificDie(dieValue: inputValue),
               // get values for the existing die associated values
               case .standardDie(let existingCount, let existingValue) = components[matchIndex],
               // check if the matched index is in parentheses
               isContainedInParentheses(componentIndex: matchIndex) == false {
                components[matchIndex] = .standardDie(count: existingCount + inputCount, value: existingValue)
                return
            }
            /* swiftlint:enable explicit_type_interface */

            components.append(component)
        }

        func backspace() {
            components.removeLast()
        }

        func clear() {
            components.removeAll()
        }

        func isContainedInParentheses(componentIndex: Int) -> Bool {
            let openingParentheses: [Calculation.Component] =
            components[0...componentIndex].filter {
                if case .parentheses(value: .opening) = $0 {
                    return true
                }
                return false
            }

            let closingParentheses: [Calculation.Component] =
            components[0...componentIndex].filter {
                if case .parentheses(value: .closing) = $0 {
                    return true
                }
                return false
            }

            return openingParentheses.count > closingParentheses.count
        }
    }
}

// MARK: - Component
extension Calculation {
    /// An enum representing the different components for a calculation method
    enum Component: Equatable {
        /// Case for a standard die
        case standardDie(count: Int = 1, value: Int)
        /// Case for a die with a custom value
        case customDie(count: Int, value: Int)
        /// Case for a numeric value
        case numeral(value: Int)
        /// Case for an operand
        case operand(value: Operand)
        /// Case for a parenthesis
        case parentheses(value: ParenthesisState)

        /// The string used to represent the component
        var displayString: String {
            switch self {
            case .standardDie(let count, let value), .customDie(let count, let value):
                return "\(count)d\(value)"

            case .numeral(value: let value):
                return String(value)

            case .operand(value: let value):
                return value.displaySymbol

            case .parentheses(value: let value):
                return value.symbol
            }
        }
    }
}
