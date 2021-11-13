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
    @Published var result: CalculationResult?
    /// The method that creates a result
    @Published var method: Method

    init(method: Method = Method()) {
        self.method = method
    }

    /// Calculate a new result for
    @discardableResult
    func calculate() -> Result<Int, CalculationError> {
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
        let calculationResult: CalculationResult = CalculationResult(value: result, method: rollsReplaced)
        self.result = calculationResult

        recordCalculation()

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

// MARK: - Method
extension Calculation {
    class Method {
        @Published var components: [Calculation.Component]

        var displayString: String {
            components.map { $0.displayString }.joined(separator: " ")
        }
        var calculationString: String {
            components.map { $0.calculationString }.joined(separator: " ")
        }

        init(components: [Calculation.Component] = [Calculation.Component]()) {
            self.components = components
        }

        /// Updates the stored components with the given component
        func update(with component: Calculation.Component) {
            switch component {
            case .standardDie(let roll):
                updateWithStandard(roll)

            case .customDie(let customRoll):
                updateWithCustomRoll(customRoll)

            case .numeral(let number):
                update(with: number)

            case .operand(let operand):
                update(with: operand)

            case .parentheses(let parenthesisState):
                update(with: parenthesisState)
            }
        }

        /// Updates the method with a specific roll
        private func updateWithStandard(_ roll: Roll) {
            // Combine any existing standard die not in parenthesis
            // check for any existing matches
            /* swiftlint:disable explicit_type_interface */
            if let matchIndex: Int = components.indexForSpecificDie(dieValue: roll.dieValue),
               // get values for the existing die associated values
               case .standardDie(let existingRoll) = components[matchIndex],
               // check if the matched index is in parentheses
               isContainedInParentheses(componentIndex: matchIndex) == false {
                let combinedRoll = Roll(count: existingRoll.count + roll.count, dieValue: existingRoll.dieValue)
                components[matchIndex] = .standardDie(roll: combinedRoll)
                return
            }
            /* swiftlint:enable explicit_type_interface */

            // If the roll does not exist, add a new one
            else {
                components.append(.standardDie(roll: roll))
            }
        }

        /// Updates the method with a custom roll
        private func updateWithCustomRoll(_ roll: Roll) {
            // Check if the previous roll was a numeral
            /* swiftlint:disable explicit_type_interface */
            if let lastComponent = components.last,
               case .numeral(let dieCount) = lastComponent {
                components.append(.customDie(roll: Roll(count: dieCount, dieValue: 0)))
                return
            }
            /* swiftlint:enable explicit_type_interface */

            components.append(.customDie(roll: Roll(count: 1, dieValue: 0)))
        }

        /// Updates the method with a specific number
        private func update(with number: Int) {
            if let lastComponent: Component = components.last {
                switch lastComponent {
                case .standardDie:
                    break

                case .customDie(let customRoll):
                    let dieValue: Int = customRoll.dieValue == 0 ? number : customRoll.dieValue.concat(number)

                    let newRoll: Roll = Roll(count: customRoll.count, dieValue: dieValue)
                    replaceLastComponent(with: .customDie(roll: newRoll))
                    return

                case .numeral(let existingNumber):
                    let concatenated: Int = existingNumber.concat(number)
                    replaceLastComponent(with: .numeral(value: concatenated))
                    return

                case .operand:
                    components.append(.numeral(value: number))
                    return

                case .parentheses(let parenthesisState):
                    switch parenthesisState {
                    case .closing:
                        break

                    case .opening:
                        components.append(.numeral(value: number))
                        return
                    }
                }

                components.append(.operand(value: .add))
                components.append(.numeral(value: number))
                return
            }

            components.append(.numeral(value: number))
        }

        /// Updates the method with a specific operand
        private func update(with operand: Operand) {
            // Prevent a calculation from starting with an Operand other than subtraction
            guard components.isEmpty == false && operand != .subtract else { return }

            if let lastComponent: Component = components.last {
                switch lastComponent {
                case .standardDie, .customDie, .numeral:
                    break

                case .operand:
                    replaceLastComponent(with: .operand(value: operand))
                    return

                case .parentheses(let parenthesisState):
                    switch parenthesisState {
                    case .closing:
                        break

                    case .opening:
                        guard operand == .subtract
                        else { return }
                    }
                }
            }

            components.append(.operand(value: operand))
        }

        /// Updates the method with a parenthesis state
        private func update(with parenthesisState: ParenthesisState) {
            switch parenthesisState {
            case .opening:
                break

            case .closing:
                // Ensure the method does not start with a closing parenthesis
                guard components.isEmpty == false else { return }
            }
            components.append(.parentheses(value: parenthesisState))
        }

        /// Removes the last component
        func backspace() {
            guard components.isEmpty == false,
            let lastComponent: Component = components.last
            else { return }

            switch lastComponent {
            case .standardDie, .operand, .parentheses:
                break

            case .customDie(let customRoll):
                let lastNumber: Int = customRoll.dieValue
                guard let deconcatenated = lastNumber.deconcat()
                else {
                    replaceLastComponent(with: .numeral(value: customRoll.count))
                    return
                }

                let newRoll: Roll = Roll(count: customRoll.count, dieValue: deconcatenated)
                replaceLastComponent(with: .customDie(roll: newRoll))
                return

            case .numeral(let number):
                guard let deconcatenated = number.deconcat()
                else {
                    break
                }
                replaceLastComponent(with: .numeral(value: deconcatenated))
                return
            }

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

        /// Replaces the last component with the given component
        func replaceLastComponent(with component: Component) {
            guard components.isEmpty == false else {
                components.append(component)
                return
            }
            let lastIndex: Int = components.endIndex - 1
            components[lastIndex] = component
        }

        /// Attempts to remove user input errors from the current method
        func cleanUp() {
            // Method should not end with an Operand
            if let lastComponent: Calculation.Component = components.last,
               case .operand = lastComponent {
                components.removeLast()
            }

            // Close all parentheses
            // TODO: Implement Method
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
}

// MARK: - Component
extension Calculation {
    /// An enum representing the different components for a calculation method
    enum Component: Equatable {
        /// Case for a standard die
        case standardDie(roll: Roll)
        /// Case for a die with a custom value
        case customDie(roll: Roll)
        /// Case for a numeric value
        case numeral(value: Int)
        /// Case for an operand
        case operand(value: Operand)
        /// Case for a parenthesis
        case parentheses(value: ParenthesisState)

        /// The string used to represent the component
        var displayString: String {
            switch self {
            case .standardDie(let roll), .customDie(let roll):
                return roll.displayString

            case .numeral(value: let value):
                return String(value)

            case .operand(value: let value):
                return value.displaySymbol

            case .parentheses(value: let value):
                return value.symbol
            }
        }

        var calculationString: String {
            switch self {
            case .standardDie, .customDie, .numeral, .parentheses:
                return displayString

            case .operand(value: let value):
                return value.symbol
            }
        }
    }
}

// MARK: - Result
extension Calculation {
    // TODO: Find better name; Result has a namespace collision
    struct CalculationResult {
        /// The  calculated value of the method
        var value: Int
        /// A description of the method with the rolled results
        var method: String
    }
}
