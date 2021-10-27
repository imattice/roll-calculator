//
//  KeyView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct KeyView: View {
    let value: String

    let borderWidth: CGFloat = 1

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(value)
                    .font(.title)
                    .minimumScaleFactor(0.8)
                Spacer()
            }
            Spacer()
        }
        .padding()

        .border(
            AppColor.KeyViews.borderColor,
            width: borderWidth)
    }

    init(_ value: String) {
        self.value = value
    }
}

// MARK: - Previews
struct KeyView_Previews: PreviewProvider {
    static let one: String = "1"
    static let two: String = "2"
    static let three: String = "3"
    static let equal: String = "="
    static let d100: String = "d100"

    static var previews: some View {
        Group {
            KeyView(one)

            HStack(spacing: 0) {
                KeyView(one)
                KeyView(two)
                KeyView(d100)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
