//
//  RollLogButton.swift
//  roll-calculator
//
//  Created by Ike Mattice on 9/2/21.
//

import SwiftUI

struct RollLogButton: View {
    let buttonImage: Image = Image(systemName: "list.dash")
    @State var isActive: Bool = true
    
    var body: some View {
        NavigationLink(destination: RollLogView(),
                       isActive: $isActive) {
            buttonImage
        }
    }
}


struct RollLogButton_Previews: PreviewProvider {
    static var previews: some View {
        RollLogButton()
            .previewLayout(.sizeThatFits)
    }
}

