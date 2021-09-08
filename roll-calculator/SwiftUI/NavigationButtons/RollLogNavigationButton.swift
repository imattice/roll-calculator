//
//  RollLogNavigationButton.swift
//  roll-calculator
//
//  Created by Ike Mattice on 9/2/21.
//

import SwiftUI

struct RollLogNavigationButton: View {
    let buttonImage: Image = Image(systemName: "list.dash")
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationLink(destination: RollLogView(),
                       isActive: $isActive) {
            buttonImage
                .onTapGesture {
                    isActive = true
                }
                .foregroundColor(AppColor.NavigationButton.rollLog)
        }
    }
}

//MARK: - Previews
struct RollLogButton_Previews: PreviewProvider {
    static var previews: some View {
        RollLogNavigationButton()
            .previewLayout(.sizeThatFits)
    }
}

