//
//  DisplayView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var calculation: Calculation

    var resultText: String {
        String(calculation.result?.value ?? 0)
    }

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                Text(resultText)
                    .font(.system(size: 100, weight: .bold))
                    .minimumScaleFactor(0.8)
                    .foregroundColor(Color.Text.primary)
                    .frame(maxHeight: 100)

                MethodDisplayView()
                    .padding(4)
                    .background(Color.App.Secondary.light)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                Color.App.Secondary.dark,
                                lineWidth: 3)
                    }
                    .cornerRadius(8)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
//        .background(
//            LinearGradient(
//                colors: [
//                    Color.App.Primary.dark,
//                    Color.Surface.medium,
//                    Color.Surface.medium,
//                    Color.Surface.medium,
//                    Color.Surface.medium,
//                    Color.Surface.medium,
//                    Color.Surface.medium,
//                    Color.Surface.medium
//                ],
//                startPoint: .bottom,
//                endPoint: .top
//            )
//        )
        .background(Color.Surface.medium)
        .shadow(color: Color.Surface.medium, radius: 3, x: 0, y: 6)
//        .frame(maxWidth: .infinity)
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
