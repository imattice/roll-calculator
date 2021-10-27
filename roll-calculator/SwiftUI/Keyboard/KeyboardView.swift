//
//  KeyboardView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct KeyboardView: View {
    // MARK: Text
    // Numbers
    let oneText: String = "1"
    let twoText: String = "2"
    let threeText: String = "3"
    let fourText: String = "4"
    let fiveText: String = "5"
    let sixText: String = "6"
    let sevenText: String = "7"
    let eightText: String = "8"
    let nineText: String = "9"
    let zeroText: String = "0"
    // Die
    let d4Text: String = "d4"
    let d6Text: String = "d6"
    let d8Text: String = "d8"
    let d10Text: String = "d10"
    let d12Text: String = "d12"
    let d20Text: String = "d20"
    let d100Text: String = "d100"
    let dXText: String = "dx"
    // Operators
    let plusText: String = "+"
    let minusText: String = "-"
    let multiplyText: String = "x"
    let divideText: String = "/"
    let equalText: String = "="

    // MARK: Spacing
    let buttonSpacing: CGFloat = 0
    var body: some View {
        // swiftlint:disable closure_body_length
        GeometryReader { geo in
            VStack(spacing: buttonSpacing) {
                HStack(spacing: buttonSpacing) {
                    DieButton(d12Text)
                    DieButton(d20Text)
                    DieButton(d100Text)
                    DieButton(dXText)
                }
                HStack(spacing: buttonSpacing) {
                    DieButton(d4Text)
                    DieButton(d6Text)
                    DieButton(d8Text)
                    DieButton(d10Text)
                }
                HStack(spacing: buttonSpacing) {
                    NumericButton(sevenText)
                    NumericButton(eightText)
                    NumericButton(nineText)
                    OpperandButton(divideText)
                }
                HStack(spacing: buttonSpacing) {
                    NumericButton(fourText)
                    NumericButton(fiveText)
                    NumericButton(sixText)
                    OpperandButton(multiplyText)
                }
                HStack(spacing: buttonSpacing) {
                    NumericButton(oneText)
                    NumericButton(twoText)
                    NumericButton(threeText)
                    OpperandButton(minusText)
                }
                HStack(spacing: buttonSpacing) {
                    NumericButton(zeroText)
                    EvaluateButton()
                        .frame(width: geo.size.width * 0.5)
                    OpperandButton(plusText)
                }
            }
        }
        // swiftlint:enable closure_body_length
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
            KeyboardView()
    }
}
