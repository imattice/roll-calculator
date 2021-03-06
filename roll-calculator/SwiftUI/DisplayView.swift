//
//  DisplayView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var calculation: Calculation

    var methodText: String {
        if calculation.method.components.isEmpty == false {
            return calculation.method.displayString
        } else {
            return ""
        }
    }

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(calculation.result?.value ?? 0))
                    .font(.largeTitle)
                    .foregroundColor(AppColor.DisplayView.resultText)
                Text(methodText)
                    .font(.title2)
                    .foregroundColor(AppColor.DisplayView.methodText)
            }
        }
        .padding()
        .background(AppColor.DisplayView.background)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Previews
struct DisplayView_Previews: PreviewProvider {
    @State static var calculation: Calculation =
    Calculation(
        method: Calculation.Method(
            components: [
                .standardDie(roll: Roll(count: 1, dieValue: 10)),
                .operand(value: .add),
                .numeral(value: 5)
            ]))

    static var previews: some View {
        DisplayView()
            .environmentObject(calculation)
            .previewLayout(.sizeThatFits)
    }
}
