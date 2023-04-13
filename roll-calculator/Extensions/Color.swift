//
//  Color.swift
//  Color
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI
// Generated Color Palette
// https://coolors.co/984447-e9d758-add9f4-476c9b-477c9a-468c98-101419

extension Color {
    static let richBlack: Color = Color("RichBlack")
    static let cordovanRed: Color = Color("Cordovan")
    static let celedonBlue: Color = Color("CeledonBlue")
    static let queenBlue: Color = Color("QueenBlue")
    static let steelBlue: Color = Color("SteelBlue")
    static let uranianBlue: Color = Color("UranianBlue")
    static let arylideYellow: Color = Color("ArylideYellow")

    init(for key: ColorKey) {
        switch key {
        case .red:
            self = .cordovanRed

        case .fallback:
            self = .cordovanRed
        }
    }
}
