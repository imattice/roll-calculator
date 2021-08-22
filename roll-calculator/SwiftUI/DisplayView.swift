//
//  DisplayView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct DisplayView: View {
    @Binding var resultText: String
    @Binding var calculationText: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
            Text(resultText)
                .font(.largeTitle)
            Text("(\(calculationText))")
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
        DisplayView(resultText: $resultText,
                    calculationText: $calculationText)
            .previewLayout(.sizeThatFits)
    }
}
