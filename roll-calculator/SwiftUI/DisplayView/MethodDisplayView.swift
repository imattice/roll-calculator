//
//  MethodDisplayView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 1/23/22.
//

import SwiftUI

struct MethodDisplayView: View {
    @EnvironmentObject var calculation: Calculation

    var methodText: String {
        if calculation.method.components.isEmpty == false {
            return calculation.method.displayString
        } else {
            return ""
        }
    }

    var methodResultText: String {
        if let result = calculation.result {
            return result.method
        } else {
            return ""
        }
    }

    var body: some View {
        ScrollViewReader { scrollView in
            GeometryReader { proxy in
                ScrollView(.horizontal) {
                    VStack(alignment: .trailing, spacing: 0) {
                        HStack {
                            Spacer()
                            Text(methodText)
                                .id("methodTextView")
                                .font(.title2)
                                .lineLimit(1)
                        }

                        HStack {
                            Spacer()
                            Text(methodResultText)
                                .font(.title2)
                                .lineLimit(1)
                        }
                    }
                    .frame(minWidth: proxy.size.width,
                           idealHeight: 44)
                }
                .onChange(of: methodText) { _ in
                    withAnimation {
                        scrollView.scrollTo("methodTextView", anchor: .trailing)
                    }
                }
            }
        }
    }
}

struct MethodDisplayView_Previews: PreviewProvider {
    @State static var calculation: Calculation =
    Calculation(
        method: Calculation.Method(
            components: [
                .standardDie(roll: Roll(count: 1, dieValue: 10)),
                .operand(value: .add),
                .numeral(value: 5)
            ]))

    static var previews: some View {
        MethodDisplayView()
            .environmentObject(calculation)
            .previewLayout(.sizeThatFits)
    }
}
