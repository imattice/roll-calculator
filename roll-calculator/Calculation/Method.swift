//
//  Method.swift
//  roll-calculator
//
//  Created by Ike Mattice on 12/9/21.
//

import Combine

// MARK: - Method
extension Calculation {
    struct Method: Equatable {
        var components: [Calculation.Component]

        var displayString: String {
            components.map { $0.displayString }.joined(separator: " ")
        }
        var calculationString: String {
            components.map { $0.calculationString }.joined(separator: " ")
        }
        var parentheticalState: ParenthesisState = .closing

        init(components: [Calculation.Component] = [Calculation.Component]()) {
            self.components = components
        }

        init?(string: String) {
            // Ensure that all string components can be decoded into Components
            guard string.components(separatedBy: .whitespaces).map({ Component(from: $0) }).contains(nil) == false else {
                return nil
            }

            self.components = string.components(separatedBy: .whitespaces).compactMap { Component(from: $0) }
        }

        /// Updates the stored components with the given component
        mutating func update(with component: Calculation.Component) {
            switch component {
            case .standardDie(let roll):
                update(.standard, with: roll)

            case .customDie(let roll):
                update(.custom, with: roll)

            case .numeral(let number):
                update(with: number)

            case .operand(let operand):
                update(with: operand)

            case .parentheses(let parenthesisState):
                update(with: parenthesisState)
            }
        }

        enum RollType {
            case custom
            case standard
        }

        /// Updates the method with a specific roll
        private mutating func update(_ rollType: RollType, with roll: Roll) {
            /* swiftlint:disable:next explicit_type_interface */
            if let last = components.last {
                switch last {
                // Check if the previous component is a numeral, capturing user's intent to roll multiple die
                /* swiftlint:disable:next explicit_type_interface */
                case .numeral(let dieCount):
                    components.removeLast()
                    appendRoll(for: rollType, with: Roll(count: dieCount, dieValue: roll.dieValue))
                    return

                case .standardDie, .customDie:
                    components.append(.operand(value: .add))

                case .operand:
                    break

                case .parentheses(let value):
                    switch value {
                    case .opening:
                        break

                    case .closing:
                        components.append(.operand(value: .add))
                    }
                }
                appendRoll(for: rollType, with: roll)
                return
            }

            // If the roll does not exist, add a new one
            else {
                appendRoll(for: rollType, with: roll)
            }
        }

        private mutating func appendRoll(for type: RollType, with roll: Roll) {
            switch type {
            case .standard:
                components.append(.standardDie(roll: roll))

            case .custom:
                components.append(.customDie(roll: roll))
            }
        }

        /// Updates the method with a specific number
        private mutating func update(with number: Int) {
            if let lastComponent: Component = components.last {
                switch lastComponent {
                case .standardDie:
                    break

                case .customDie(let customRoll):
                    let dieValue: Int = customRoll.dieValue == 0 ? number : customRoll.dieValue.concat(number)

                    let newRoll: Roll = Roll(count: customRoll.count, dieValue: dieValue)
                    replaceLastComponent(with: .customDie(roll: newRoll))
                    return

                case .numeral(let existingNumber):
                    let concatenated: Int = existingNumber.concat(number)
                    replaceLastComponent(with: .numeral(value: concatenated))
                    return

                case .operand:
                    components.append(.numeral(value: number))
                    return

                case .parentheses(let parenthesisState):
                    switch parenthesisState {
                    case .closing:
                        break

                    case .opening:
                        components.append(.numeral(value: number))
                        return
                    }
                }

                components.append(.operand(value: .add))
                components.append(.numeral(value: number))
                return
            }

            components.append(.numeral(value: number))
        }

        /// Updates the method with a specific operand
        private mutating func update(with operand: Operand) {
            // Prevent a calculation from starting with an Operand other than subtraction
            if components.isEmpty && operand != .subtract { return }

            if let lastComponent: Component = components.last {
                switch lastComponent {
                case .standardDie, .customDie, .numeral:
                    break

                case .operand:
                    replaceLastComponent(with: .operand(value: operand))
                    return

                case .parentheses(let parenthesisState):
                    switch parenthesisState {
                    case .closing:
                        break

                    case .opening:
                        guard operand == .subtract
                        else { return }
                    }
                }
            }

            components.append(.operand(value: operand))
        }

        /// Updates the method with a parenthesis state
        private mutating func update(with parenthesisState: ParenthesisState) {
            /* swiftlint:disable:next explicit_type_interface */
            switch parenthesisState {
            case .opening:
                guard parentheticalState == .closing else { return }

            case .closing:
                // Ensure the method does not start with a closing parenthesis
                // Ensure there is an open parenthesis
                guard components.isEmpty == false,
                      parentheticalState == .opening else { return }

                // Ensure an empty parenthetical clause is not created
                if let last = components.last,
                   case .parentheses(let state) = last,
                   case .opening = state {
                          components.removeLast()
                    parentheticalState = .closing
                          return
                }
            }
            parentheticalState = parenthesisState
            components.append(.parentheses(value: parenthesisState))
        }

        /// Removes the last component
        mutating func backspace() {
            guard components.isEmpty == false,
            let lastComponent: Component = components.last
            else { return }

            switch lastComponent {
            case .operand, .parentheses:
                break

            case .standardDie(let roll):
                components.removeLast()
                if roll.count != 1 {
                    components.append(.numeral(value: roll.count))
                }
                return

            case .customDie(let customRoll):
                let lastNumber: Int = customRoll.dieValue
                guard let deconcatenated = lastNumber.deconcat()
                else {
                    replaceLastComponent(with: .numeral(value: customRoll.count))
                    return
                }

                let newRoll: Roll = Roll(count: customRoll.count, dieValue: deconcatenated)
                replaceLastComponent(with: .customDie(roll: newRoll))
                return

            case .numeral(let number):
                guard let deconcatenated = number.deconcat()
                else {
                    break
                }
                replaceLastComponent(with: .numeral(value: deconcatenated))
                return
            }

            components.removeLast()
        }

        /// Remove all components
        mutating func clear() {
            components.removeAll()
        }

        func isContainedInParentheses(componentIndex: Int) -> Bool {
            let openingParentheses: [Calculation.Component] =
            components[0...componentIndex].filter {
                if case .parentheses(value: .opening) = $0 {
                    return true
                }
                return false
            }

            let closingParentheses: [Calculation.Component] =
            components[0...componentIndex].filter {
                if case .parentheses(value: .closing) = $0 {
                    return true
                }
                return false
            }

            return openingParentheses.count > closingParentheses.count
        }

        /// Replaces the last component with the given component
        mutating func replaceLastComponent(with component: Component) {
            guard components.isEmpty == false else {
                components.append(component)
                return
            }
            let lastIndex: Int = components.endIndex - 1
            components[lastIndex] = component
        }

        /// Attempts to remove user input errors from the current method
        mutating func cleanUp() {
            guard let lastComponent: Calculation.Component = components.last else { return }

            // Method should not end with an Operand
            if case .operand = lastComponent {
                components.removeLast()

            // Method should not end with an open parenthesis
            /* swiftlint:disable:next explicit_type_interface */
            } else if case .parentheses(let state) = lastComponent,
            state == .opening {
                components.removeLast()
                parentheticalState = .closing
            }

            // Close any open parenthesis
            if parentheticalState == .opening {
                components.append(.parentheses(value: .closing))
            }
        }

        /// Removes operands from the end of the current method
        private func removeTrailingOperands(from string: String) -> String {
            var processedString: String = string
            if let lastCharacter: String.Element = string.last,
               Operand.symbolStrings.contains(String(lastCharacter)) {
                processedString.removeLast()
                processedString = processedString.trimmingCharacters(in: .whitespacesAndNewlines)

                return removeTrailingOperands(from: processedString)
            }

            return processedString
        }

        // TODO: Update this method to look for any roll in the components, not just the first
        private mutating func combineRollsIfNeeded(_ specificRoll: Roll) {
            // Combine any existing standard die not in parenthesis
            // check for any existing matches
            /* swiftlint:disable:next explicit_type_interface */
            if let matchIndex: Int = components.indexForSpecificDie(dieValue: specificRoll.dieValue),
               // get values for the existing die associated values
               case .standardDie(let existingRoll) = components[matchIndex],
               // check if the matched index is in parentheses
               isContainedInParentheses(componentIndex: matchIndex) == false {
                let combinedRoll = Roll(count: existingRoll.count + specificRoll.count, dieValue: existingRoll.dieValue)
                components[matchIndex] = .standardDie(roll: combinedRoll)
                return
            }
        }
    }
}
