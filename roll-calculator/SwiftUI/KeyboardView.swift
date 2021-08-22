//
//  KeyboardView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct KeyboardView: View {
    
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
    
    let plusText: String = "+"
    let minusText: String = "-"
    let multiplyText: String = "x"
    let divideText: String = "/"
    let equalText: String = "="
    
    let buttonSpacing: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: buttonSpacing) {
                HStack(spacing: buttonSpacing) {
                    KeyView(sevenText)
                    KeyView(eightText)
                    KeyView(nineText)
                    KeyView(divideText)
                }
                HStack(spacing: buttonSpacing) {
                    KeyView(fourText)
                    KeyView(fiveText)
                    KeyView(sixText)
                    KeyView(multiplyText)
                    
                }
                HStack(spacing: buttonSpacing) {
                    KeyView(oneText)
                    KeyView(twoText)
                    KeyView(threeText)
                    KeyView(minusText)
                }
                HStack(spacing: buttonSpacing) {
                    KeyView(zeroText)
                    KeyView(equalText)
                        .frame(width: geo.size.width * 1/2)
                    KeyView(plusText)
                }
            }
            .frame(maxHeight: geo.size.height * 2/3)
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
            KeyboardView()
    }
}
