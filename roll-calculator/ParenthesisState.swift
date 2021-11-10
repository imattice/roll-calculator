//
//  ParenthesisState.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/10/21.
//

enum ParenthesisState {
    case opening
    case closing

    var symbol: String {
        switch self {
        case .opening:
            return "("
        case .closing:
            return ")"
        }
    }
}
