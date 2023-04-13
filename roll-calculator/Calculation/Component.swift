//
//  Component.swift
//  roll-calculator
//
//  Created by Ike Mattice on 12/9/21.
//

// MARK: - Component
extension Calculation {
    /// An object representing the different components for a calculation method
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

        init?(from string: String) {
            // Look for die roll values
            if string.matches(.dieRoll) {
                guard let roll = try? Roll(fromString: string) else {
                    return nil
                }
                self = .standardDie(roll: roll)

            // Look for numeric values
            } else if string.matches(.numeric) {
                guard let number = Int(string) else {
                    return nil
                }
                self = .numeral(value: number)

            // Look for parenthesis
            } else if string.matches(.parenthesis) {
                self = .parentheses(value: string == "(" ? .opening : .closing)

            // Look for operands
            } else if string.matches(.operand) {
                guard let operand: Operand = Operand(from: string) else {
                    return nil
                }
                self = .operand(value: operand)

            // In all other cases, return nil
            } else {
                return nil
            }
        }
    }
}
