//
//  AppColor.swift
//  AppColor
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

enum AppColor {
    enum KeyViews {
        enum Numeric {
            static let text: Color = .uranianBlue
            static let background: Color = .steelBlue
        }
        enum Die {
            static let text: Color = .arylideYellow
            static let background: Color = .steelBlue
        }
        enum Operand {
            static let text: Color = .cordovanRed
            static let background: Color = .steelBlue
        }
        enum Evaluate {
            static let text: Color = .cordovanRed
            static let background: Color = .steelBlue
        }

        static let borderColor: Color = .richBlack
    }

    enum DisplayView {
        static let background: Color = .queenBlue
        static let resultText: Color = .cordovanRed
        static let methodText: Color = .steelBlue
    }

    enum NavigationButton {
        static let rollLog: Color = .richBlack
    }

    static let textPrimary: Color = .richBlack
}
