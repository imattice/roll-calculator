//
//  Operand.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/10/21.
//

enum Operand {
    case plus
    case minus
    case multiply
    case divide

    var symbol: String {
        switch self {
        case .plus:
            return "+"

        case .minus:
            return "-"

        case .multiply:
            return "*"

        case .divide:
            return "/"
        }
    }

    var displaySymbol: String {
        switch self {
        case .plus, .minus:
            return symbol

        case .multiply:
            return "\u{00D7}"

        case .divide:
            return "\u{00F7}"
        }
    }
}

extension Operand {
    static let symbolStrings: [String] = [
        "+",
        "-",
        "*",
        "/",
        "\u{00D7}",
        "\u{00F7}"
    ]
}
