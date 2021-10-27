//  AccessibiltyTextPreview.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

/// Displays content given the selected dynamic sizes
struct AccessibiltyTextPreview<Content: View>: View {
    /// The views to display
    let content: () -> Content
    /// The text sizes to display
    let sizes: [DynamicTypeSize]

    var body: some View {
        ForEach(sizes, id:\.self) { size in
            content()
                .dynamicTypeSize(size)
                .previewDisplayName("\(String(describing: size).capitalized) Text")
        }
    }

    init(sizes: SizeOption = .standard, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.sizes = sizes.sizes
    }
}

// MARK: - Size Option Definition
extension AccessibiltyTextPreview {
    /// Defines a standardized group of Dynamic types
    enum SizeOption {
        /// An option for a standard group of text sizes
        case standard
        /// An option for all accessible text sizes
        case accessibilty
        /// An option for all possible text sizes
        case all
        /// An option for a custom group of text sizes
        case custom([DynamicTypeSize])
        /// Returns a group of text sizes based on the current option
        var sizes: [DynamicTypeSize] {
            switch self {
            case .standard:
                return [
                    .small,
                    .medium,
                    .large,
                    .xxxLarge
                ]

            case .accessibilty:
                return [
                    .accessibility1,
                    .accessibility2,
                    .accessibility3,
                    .accessibility4,
                    .accessibility5
                ]

            case .all:
                return DynamicTypeSize.allCases

            case .custom(let sizes):
                return sizes
            }
        }
    }
}

// MARK: - Previews
struct AccessibiltyTextPreview_Previews: PreviewProvider {
    static var previews: some View {
        AccessibiltyTextPreview {
            Text("Test Text")
                .previewLayout(.sizeThatFits)
        }
    }
}
