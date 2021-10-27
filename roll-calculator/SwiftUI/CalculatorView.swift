//
//  CalculatorView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct CalculatorView: View {
    let displayViewScaleFactor: CGFloat = 1 / 4
    let keyboardViewScaleFactor: CGFloat = 3 / 4

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                DisplayView()
                KeyboardView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    RollLogNavigationButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    ProfileNavigationButton()
                }
            }
        }
    }
}

// MARK: - Previews
struct CalculatorView_Previews: PreviewProvider {
    @State static var calculation: Calculation = Calculation(method: "3d8+4", result: "24")

    static var previews: some View {
        CalculatorView()
            .previewLayout(.sizeThatFits)
            .environmentObject(calculation)
    }
}
