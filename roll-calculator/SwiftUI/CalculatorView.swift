//
//  CalculatorView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct CalculatorView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorView()
            CalculatorView()
        }
        .previewLayout(.sizeThatFits)
    }
}
