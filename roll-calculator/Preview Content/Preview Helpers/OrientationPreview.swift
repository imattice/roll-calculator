//
//  OrientationPreview.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

/// Displays content given the given device orientations
struct OrientationPreview<Content: View>: View {
    /// The views to display
    let content: () -> Content
    /// The orientations to display
    let orientations: [InterfaceOrientation]
    /// An optional device on which to display the orientations
    let device: iOSDevice?

    var body: some View {
        ForEach(orientations, id:\.self) { orientation in
            content()
                .previewInterfaceOrientation(orientation)
                .previewDevice(PreviewDevice(rawValue: device?.name ?? ""))
                .previewDisplayName("\(String(describing: orientation).capitalized) Device")
        }
    }

    init(orientations: [InterfaceOrientation] = InterfaceOrientation.allCases,
         device: iOSDevice? = nil,
         @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.orientations = orientations
        self.device = device
    }
}

// MARK: - Previews
struct OrientationPreview_Previews: PreviewProvider {
    static var previews: some View {
        OrientationPreview {
            Text("Text Preview")
        }
    }
}
