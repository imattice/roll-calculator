//
//  OperandButton.swift
//  OperandButton
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

struct OperandButton: View {
    @EnvironmentObject var calculation: Calculation

    let value: String

    var body: some View {
        KeyView(value)
            .foregroundColor(AppColor.KeyViews.Operand.text)
            .background(AppColor.KeyViews.Operand.background)
            .font(Font.bold(.title)())
            .onTapGesture {
                onTap()
            }
    }

    init(_ value: String) {
        self.value = value
    }

    func onTap() {
//        calculation.method += value
    }
}

// MARK: - Previews
struct OperandButton_Previews: PreviewProvider {
    static let plus: String = "+"
    static let minus: String = "-"

    static var previews: some View {
        OperandButton(plus)
    }
}
