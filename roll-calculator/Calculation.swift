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

// MARK: - Update Methods
extension Calculation {
    dynamic func update(_ value: ButtonValue) {
        switch value {
        case .die(let value):
            update(with: Roll(dieValue: value))

        case .numeral(let number):
            update(with: number)

        case .operand(let operand):
            update(with: operand)

        case .parentheses(let parenthesisState):
            update(with: parenthesisState)

        case .backspace:
            backspace()

        case .clear:
            clear()
        }
    }

    private func update(with roll: Roll) {
        // Check if the roll already exists in the calculation method
        // Check that the roll is not contained in parentheses
        if let matchRange: Range = method.range(of: Regex.specificRoll(roll.dieValue).pattern, options: [.regularExpression]),
           method[matchRange.lowerBound] != "(",
           let existingRoll: Roll = try? Roll(fromString: String(method[matchRange])) {
            method = method.replacingCharacters(in: matchRange, with: "\(existingRoll.count + 1)d\(existingRoll.dieValue)")

            return
        }

        // If the roll does not exist, add a new one
        else {
            method += "\(roll.count)d\(roll.dieValue)"
        }
    }

    private func update(with number: Int) {
        // Check if the previous value was a die roll
        let components: [Substring] = method.split(separator: " ")
        if let lastComponent: Substring = components.last,
           lastComponent.contains("d") {
            update(with: .plus)
        }
        method += String(number)
    }

    private func update(with operand: Operand) {
        // Prevent a calculation from starting with an Operand
        guard method.isEmpty == false else { return }

        // Remove any trailing whitespace
        method = method.trimmingCharacters(in: .whitespacesAndNewlines)

        // Change method if last value in method is another Operand
        if let lastCharacter: String.Element = method.last,
            Operand.symbolStrings.contains(String(lastCharacter)) {
            method.removeLast()
            method = method.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        method += " \(operand.symbol) "
    }

    private func update(with parenthesisState: ParenthesisState) {
        switch parenthesisState {
        case .opening:
            method += "\(parenthesisState.symbol) "

        case .closing:
            // Ensure the method does not start with a closing parenthesis
            guard method.isEmpty == false else { return }

            method += " \(parenthesisState.symbol)"
        }
    }

    private func backspace() {
        // Break the method into components and get the last component
        let components: [Substring] = method.split(separator: " ")
        guard let lastComponent = components.last else { return }

        // Check if the last component was an operand
        if Operand.symbolStrings.contains(String(lastComponent)) {
            method.removeLast(3)
            return
        }

        // Check if the last component was a parenthesis
        else if ParenthesisState.symbolStrings.contains(String(lastComponent)){
            method.removeLast(2)
            return
        }

        // Check if the last component was a die roll
        else if lastComponent.contains("d") {
            method.removeLast(lastComponent.count)
            return
        }

        // In all other cases, remove the last value
        method.removeLast()
    }

    private func clear() {
        method.removeAll()
    }
}
