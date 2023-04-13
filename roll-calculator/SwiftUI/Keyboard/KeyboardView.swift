//
//  KeyboardView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct KeyboardView: View {
    var body: some View {
        // swiftlint:disable:next closure_body_length
        VStack {
            HStack {
                KeyView(.roll(.d12))
                KeyView(.roll(.d20))
                KeyView(.roll(.d100))
                KeyView(.roll(Roll(dieValue: 0)))
            }
            HStack {
                KeyView(.roll(.d4))
                KeyView(.roll(.d6))
                KeyView(.roll(.d8))
                KeyView(.roll(.d10))
            }
            HStack {
                KeyView(.parenthesis(.opening))
                KeyView(.parenthesis(.closing))
                KeyView(.clear)
                KeyView(.backspace)
            }
            HStack {
                KeyView(.numeral(7))
                KeyView(.numeral(8))
                KeyView(.numeral(9))
                KeyView(.operand(.divide))
            }
            HStack {
                KeyView(.numeral(4))
                KeyView(.numeral(5))
                KeyView(.numeral(6))
                KeyView(.operand(.multiply))
            }
            HStack {
                KeyView(.numeral(1))
                KeyView(.numeral(2))
                KeyView(.numeral(3))
                KeyView(.operand(.subtract))
            }
            HStack {
                KeyView(.numeral(0))
                KeyView(.evaluate)
                KeyView(.operand(.add))
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
