//
//  ProfileNavigationButton.swift
//  ProfileNavigationButton
//
//  Created by Ike Mattice on 9/7/21.
//

import SwiftUI

struct ProfileNavigationButton: View {
    let buttonImage: Image = Image(systemName: "person.crop.circle")
    @State var isActive: Bool = false

    var body: some View {
        NavigationLink(
            destination: Text("This view is a work in progress"),
            isActive: $isActive) {
                buttonImage
                    .onTapGesture {
                        isActive = true
                    }
                    .foregroundColor(AppColor.NavigationButton.rollLog)
        }
    }
}

// MARK: - Previews
struct ProfileNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        RollLogNavigationButton()
            .previewLayout(.sizeThatFits)
    }
}
