//
//  Array.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/10/21.
//

/// Supporting methods for getting information about an array of CalculationComponent
extension Array where Element == Calculation.Component {
    /// Returns the first index of the component of the specified die, if any
    func indexForSpecificDie(dieValue: Int) -> Int? {
        firstIndex {
            /* swiftlint:disable explicit_type_interface */
            if case .standardDie(_, let value) = $0 {
            /* swiftlint:enable explicit_type_interface */
                return value == dieValue
            }
            return false
        }
    }
}
