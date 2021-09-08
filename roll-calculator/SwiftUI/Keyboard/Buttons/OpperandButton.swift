//
//  OpperandButton.swift
//  OpperandButton
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

struct OpperandButton: View {
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
struct OpperandButton_Previews: PreviewProvider {
    static let plus: String = "="
    static let minus: String = "-"

    static var previews: some View {
        OpperandButton(plus)
    }
}
