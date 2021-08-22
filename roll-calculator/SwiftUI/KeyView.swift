//
//  KeyView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

struct KeyView: View {
    @EnvironmentObject var calculation: Calculation
    let value: String
    
    let fontColor: Color = .yellow
    let backgroundColor: Color = .gray
    let borderColor: Color = .black
    let borderWidth: CGFloat = 1
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(value)
                    .font(.title)
                Spacer()
            }
            Spacer()
        }
        .padding()
        .foregroundColor(fontColor)
        .background(backgroundColor)
        .border(borderColor,
                width: borderWidth)
        .onTapGesture {
            calculation.method += value
        }
    }
    
    init(_ value: String) {
        self.value = value
    }
}

//MARK: - Previews
struct KeyView_Previews: PreviewProvider {
    static let one: String = "1"
    static let two: String = "2"
    static let three: String = "3"
    static let equal: String = "="
    
    static var previews: some View {
        Group {
            KeyView(one)
            
            HStack(spacing: 0) {
                KeyView(one)
                KeyView(two)
                KeyView(three)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
