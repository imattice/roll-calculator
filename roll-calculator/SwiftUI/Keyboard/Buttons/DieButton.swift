//
//  DieButton.swift
//  DieButton
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

struct DieButton: View {
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
struct DieButton_Previews: PreviewProvider {
    static let d4: String = "d4"
    static let d10: String = "d10"

    static var previews: some View {
        DieButton(d4)
    }
}
