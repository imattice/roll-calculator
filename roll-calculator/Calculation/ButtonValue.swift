//
//  ButtonValue.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/10/21.
//

enum ButtonValue {
    case die(value: Int)
    case numeral(value: Int)
    case operand(value: Operand)
    case parentheses(value: ParenthesisState)
    case backspace
    case clear
}
