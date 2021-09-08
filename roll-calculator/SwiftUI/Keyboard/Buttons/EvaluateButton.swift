//
//  EvaluateButton.swift
//  EvaluateButton
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

struct EvaluateButton: View {
    @EnvironmentObject var calculation: Calculation

    var body: some View {
        KeyView("=")
            .onTapGesture {
                onTap()
            }
    }
    
    func onTap() {
        calculation.calculate()
    }
}

struct EvaluateButton_Previews: PreviewProvider {
    static var previews: some View {
        EvaluateButton()
    }
}
