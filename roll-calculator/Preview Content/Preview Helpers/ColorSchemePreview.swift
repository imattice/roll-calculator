//
//  ColorSchemePreview.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

/// Displays content in all available Color Schemes
struct ColorSchemePreview<Content: View>: View {
    /// The views to display
    let content: () -> Content

    var body: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            content()
                .previewDisplayName("\(String(describing: scheme).capitalized) Mode")
        }
    }

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}

// MARK: - Previews
struct ColorSchemePreview_Previews: PreviewProvider {
    static var previews: some View {
        ColorSchemePreview {
            Text("Text text")
                .previewLayout(.sizeThatFits)
        }
    }
}
