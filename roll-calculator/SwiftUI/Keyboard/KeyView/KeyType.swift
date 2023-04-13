//
//  KeyType.swift
//  roll-calculator
//
//  Created by Ike Mattice on 1/15/22.
//

import SwiftUI

/// Describes the options available for calculator keyboard keys
enum KeyType {
    case numeral(_ number: Int)
    case roll(_ roll: Roll)
    case operand(_ operand: Operand)
    case parenthesis(_ state: ParenthesisState)

    case aptitude(_ state: RollAptitude)

    case backspace
    case clear

    case evaluate

    var text: String? {
        switch self {
        case .numeral(let number):
            return String(number)

        case .roll(let roll):
            let value: String = roll.dieValue <= 0 ? "x" : String(roll.dieValue)

            return "d\(value)"

        case .parenthesis(let parenState):
            return parenState.symbol

        case .evaluate:
            return "Roll!"

        case .operand,
                .clear,
                .aptitude,
                .backspace:
//                .evaluate:
            return nil
        }
    }

    var image: Image? {
        switch self {
        case .numeral,
                .roll,
                .evaluate,
                .parenthesis:
            return nil

        case .operand(let operand):
            switch operand {
            case .add:
                return Image(systemName: "plus")

            case .subtract:
                return Image(systemName: "minus")

            case .multiply:
                return Image(systemName: "multiply")

            case .divide:
                return Image(systemName: "divide")
            }

        case .aptitude(let state):
            switch state {
            case .advantage:
                return Image(systemName: "arrow.up.circle")

            case .disadvantage:
                return Image(systemName: "arrow.down.circle")

            case .standard:
                return Image(systemName: "minus.circle")
            }

        case .backspace:
            return Image(systemName: "delete.backward")

        case .clear:
            return Image(systemName: "clear")

//        case .evaluate:
//            return Image(systemName: "die.face.1")
        }
    }

    var textColor: Color {
        switch self {
        case .numeral:
            return Color.Text.inverse

        case .roll:
            return Color.Text.primary

        case .operand, .parenthesis, .aptitude, .backspace, .clear, .evaluate:
            return Color.Text.primary
        }
    }

    var backgroundColor: Color {
        switch self {
        case .roll:
            return Color.App.Secondary.light

        case .numeral:
            return Color.Surface.high

        case .operand, .evaluate, .backspace, .clear, .parenthesis, .aptitude:
            return Color.Surface.low
        }
    }

    var buttonSize: CGSize {
        switch self {
        case .numeral,
                .operand,
                .parenthesis,
                .aptitude,
                .backspace,
                .clear:
            return CGSize(width: 1, height: 1)

        case .evaluate:
            return CGSize(width: 2.8, height: 1)

        case .roll:
            return CGSize(width: 1, height: 0.5)
        }
    }

    var component: Calculation.Component? {
        switch self {
        case .numeral(let number):
            return .numeral(value: number)
            
        case .roll(let roll):
            return roll.dieValue == 0 ? .customDie(roll: roll) : .standardDie(roll: roll)

        case .operand(let operand):
            return .operand(value: operand)

        case .parenthesis(let state):
            return .parentheses(value: state)

        case .aptitude,
                .backspace,
                .clear,
                .evaluate:
            return nil
        }
    }
}
