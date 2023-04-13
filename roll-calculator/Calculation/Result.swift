//
//  CalculationResult.swift
//  roll-calculator
//
//  Created by Ike Mattice on 12/9/21.
//

// MARK: - Result
extension Calculation {
    /// Contains the result value from a calculation
    struct Result {
        /// The  calculated value of the method
        var value: Int
        /// A description of the method with the rolled results
        var method: String
    }
}
