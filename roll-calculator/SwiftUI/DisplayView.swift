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
        if calculation.method != "" {
            return "(\(calculation.method))"
        }
        else {
            return ""
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Text(calculation.result)
                    .font(.largeTitle)
                Text(methodText)
                    .font(.caption)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct DisplayView_Previews: PreviewProvider {
    @State static var resultText: String = "64"
    @State static var calculationText: String = "16d8"
    
    static var previews: some View {
        DisplayView()
            .previewLayout(.sizeThatFits)
    }
}
