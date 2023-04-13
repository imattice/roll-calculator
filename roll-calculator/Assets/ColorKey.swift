//
//  ColorKey.swift
//  roll-calculator
//
//  Created by Ike Mattice on 12/12/21.
//

import SwiftUI

/// App Specific colors
enum ColorKey: String, CaseIterable {
    // TODO: Implement all color options
    case fallback
    case red
//    case custom(r: Double, g: Double, b: Double)

    static func key(for color: Color) -> ColorKey {
        switch color {
        case .cordovanRed:
            return .red

        default:
            ErrorLog.shared.recordError(
                class: String(describing: self),
                function: #function,
                description: "Needed to use fallback Color")
            return .fallback
        }
    }
}
