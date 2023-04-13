//
//  KeyView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct KeyView: View {
    @EnvironmentObject var calculation: Calculation

    let keyType: KeyType

    let baseKeySize: CGFloat = 40

    let borderWidth: CGFloat = 2
    let cornerRadius: CGFloat = 12

    var body: some View {
        Button(action: tapButton, label: { keyView })
    }

    @ViewBuilder
    var keyView: some View {
        Group {
            if let text: String = keyType.text {
                Text(text)
            } else if let image: Image = keyType.image {
                image
                    .aspectRatio(contentMode: .fit)
            } else {
                EmptyView()
            }
        }
        .frame(minWidth: 20 * keyType.buttonSize.width,
               idealWidth: 40 * keyType.buttonSize.width,
               maxWidth: 60 * keyType.buttonSize.width,
               minHeight: 20 * keyType.buttonSize.height,
               idealHeight: 40 * keyType.buttonSize.height,
               maxHeight: 60 * keyType.buttonSize.height,
               alignment: .center)
        .font(font)
        .foregroundColor(keyType.textColor)
        .minimumScaleFactor(0.5)
        .padding()
        .background(keyType.backgroundColor)
        .cornerRadius(cornerRadius)
        .shadow(color: .black, radius: 3, x: 6, y: 6)
        .overlay(
            RoundedRectangle(
                cornerRadius: cornerRadius)
            .stroke(Color.Surface.low,
                    lineWidth: borderWidth))
    }

    init(_ type: KeyType) {
        self.keyType = type
    }

    var font: Font {
        switch keyType {
        case .evaluate:
                return .title.bold()
            
        default:
                return .title
        }
    }

    func tapButton() {
        switch keyType {
        case .numeral,
                .roll,
                .operand,
                .parenthesis:
            updateMethod()

        case .aptitude:
            // TODO: Implement aptitude
            break

        case .backspace:
            calculation.backspace()

        case .clear:
            calculation.clear()

        case .evaluate:
            calculation.evaluate()
        }
    }

    func updateMethod() {
        guard let component = keyType.component else {
            ErrorLog.shared.recordError(
                class: String(describing: self),
                function: #function,
                description: "Failed to update method with component made from keyType '\(keyType)'")
            return
        }

        calculation.updateMethod(with: component)
    }
}

// MARK: - Previews
struct KeyView_Previews: PreviewProvider {
    static let one: KeyType = .numeral(1)
    static let two: KeyType = .numeral(2)
    static let three: KeyType = .numeral(3)
    static let multiply: KeyType = .operand(.multiply)
    static let d100: KeyType = .roll(Roll(dieValue: 100))

    static var previews: some View {
        Group {
            KeyView(one)

            HStack {
                KeyView(one)
                KeyView(two)
                KeyView(d100)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
