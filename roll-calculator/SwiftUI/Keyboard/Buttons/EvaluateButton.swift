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
            .foregroundColor(AppColor.KeyViews.Evaluate.text)
            .background(AppColor.KeyViews.Evaluate.background)
            .onTapGesture {
                onTap()
            }
    }
    
    func onTap() {
        calculation.calculate()
    }
}

//MARK: - Previews
struct EvaluateButton_Previews: PreviewProvider {
    static var previews: some View {
        EvaluateButton()
    }
}
