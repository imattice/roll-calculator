//
//  CalculatorView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct CalculatorView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    DisplayView()
                        .frame(maxWidth: .infinity, maxHeight: geo.size.height / 4)

                    KeyboardView()
                        .padding()
                        .background(Color.App.Primary.dark)
                }
            }
        }
    }
}

// MARK: - Previews
struct CalculatorView_Previews: PreviewProvider {
    @State static var calculation: Calculation =
    Calculation(method: Calculation.Method(components: [
        .standardDie(roll: Roll(count: 3, dieValue: 8)),
        .operand(value: .add),
        .numeral(value: 4)
    ]))

    static var previews: some View {
        CalculatorView()
            .previewLayout(.sizeThatFits)
            .environmentObject(calculation)
    }
}
