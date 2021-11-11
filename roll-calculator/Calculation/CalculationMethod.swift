//
//  CalculationMethod.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/10/21.
//

import Foundation

class CalculationMethod: ObservableObject {
    @Published var components: [CalculationComponent]

    var displayString: String {
        components.map { $0.stringRepresentation }.joined(separator: " ")
    }

    init(components: [CalculationComponent] = [CalculationComponent]()) {
        self.components = components
    }

    func update(with component: CalculationComponent) {
        // Combine any existing standard die not in parenthesis
        /* swiftlint:disable explicit_type_interface */
        //check that the entered component is a die roll
        if case .die(let inputCount, let inputValue) = component,
           // check if there is a match in the components
           let matchIndex: Int = components.indexForSpecificDie(dieValue: inputValue),
           // get values for the existing die associated values
           case .die(let existingCount, let existingValue) = components[matchIndex],
           // check if the matched index is in parentheses
           isContainedInParentheses(componentIndex: matchIndex) == false {
            components[matchIndex] = .die(count: existingCount + inputCount, value: existingValue)
            return
        }
        /* swiftlint:enable explicit_type_interface */

        components.append(component)
    }

    func backspace() {
        components.removeLast()
    }

    func clear() {
        components.removeAll()
    }

    func isContainedInParentheses(componentIndex: Int) -> Bool {
        let openingParentheses: [CalculationComponent] =
        components[0...componentIndex].filter {
            if case .parentheses(value: .opening) = $0 {
                return true
            }
            return false
        }

        let closingParentheses: [CalculationComponent] =
        components[0...componentIndex].filter {
            if case .parentheses(value: .closing) = $0 {
                return true
            }
            return false
        }

        return openingParentheses.count > closingParentheses.count
    }
}
