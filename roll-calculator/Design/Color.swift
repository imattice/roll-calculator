//
//  Color.swift
//  Color
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

extension Color {
    enum App {
        static let tint: Color = Color("App/Tint")

        enum Primary {
            static let light: Color = Color("App/Primary/Light")
            static let dark: Color = Color("App/Primary/Dark")
        }

        enum Secondary {
            static let light: Color = Color("App/Secondary/Light")
            static let dark: Color = Color("App/Secondary/Dark")
        }
    }

    enum Surface {
        static let low: Color = Color("Surface/Low")
        static let medium: Color = Color("Surface/Medium")
        static let high: Color = Color("Surface/High")
    }

    enum Text {
        static let primary: Color = Color("Text/Primary")
        static let inverse: Color = Color("Text/Inverse")
    }
}
