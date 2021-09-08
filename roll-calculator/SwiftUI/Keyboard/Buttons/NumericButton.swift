//
//  NumericButton.swift
//  NumericButton
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

struct NumericButton: View {
    @EnvironmentObject var calculation: Calculation

    let value: String
    
    var body: some View {
        KeyView(value)
            .onTapGesture {
                onTap()
            }
    }
    
    init(_ value: String) {
        self.value = value
    }
    
    func onTap() {
        calculation.method += value
    }
}


//MARK: - Previews
struct NumericButton_Previews: PreviewProvider {
    static let one: String = "1"

    static var previews: some View {
        NumericButton(one)
    }
}
