//
//  AppColor.swift
//  AppColor
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

enum AppColor {
    enum KeyViews {
        static let defaultText: Color = .black
        static let defaultBackground: Color = .white

        enum Numeric {
            static let text: Color = .black
            static let background: Color = .white
        }
        enum Die {
            static let text: Color = .arylideYellow
            static let background: Color = .steelBlue
        }
        enum Operand {
            static let text: Color = .cordovanRed
            static let background: Color = .steelBlue
        }
        enum Parenthesis {
            static let text: Color = .black
            static let background: Color = .white
        }
        enum Advantage {
            static let text: Color = .black
            static let background: Color = .white
        }
        enum Backspace {
            static let text: Color = .black
            static let background: Color = .white
        }
        enum Clear {
            static let text: Color = .black
            static let background: Color = .white
        }
        enum Evaluate {
            static let text: Color = .cordovanRed
            static let background: Color = .steelBlue
        }

        static let borderColor: Color = .richBlack
    }

    enum DisplayView {
        static let background: Color = .queenBlue
        static let resultText: Color = .white
        static let methodText: Color = .white
    }

    enum NavigationButton {
        static let rollLog: Color = .richBlack
    }

    static let textPrimary: Color = .richBlack
}
