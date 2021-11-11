//
//  CalculationComponent.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/10/21.
//

enum CalculationComponent: Equatable {
    case die(count: Int = 1, value: Int)
    case customDie(count: Int, value: Int)
    case numeral(value: Int)
    case operand(value: Operand)
    case parentheses(value: ParenthesisState)

    var stringRepresentation: String {
        switch self {
        case .die(let count, let value), .customDie(let count, let value):
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
