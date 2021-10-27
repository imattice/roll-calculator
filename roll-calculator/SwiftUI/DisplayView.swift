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
        if calculation.method.isEmpty == false {
            return String(calculation.method)
        } else {
            return ""
        }
    }

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Text(calculation.result)
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
    @State static var calculation: Calculation = Calculation(method: "1d10+5", result: "13")

    static var previews: some View {
        DisplayView()
            .environmentObject(calculation)
            .previewLayout(.sizeThatFits)
    }
}
