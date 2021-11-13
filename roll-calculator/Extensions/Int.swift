//
//  Int.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/11/21.
//

/// An extension for concatenating and deconcatenating int values
extension Int {
    /// Concatenates self with the given number
    func concat(_ int: Int) -> Int {
        guard let concatenated = Int("\(self)\(int)") else {
            // TODO: Record Error here
            return 0
        }

        return concatenated
    }

    /// Removes the last number in the given int, returning the new value and throwing away the removed value
    func deconcat() -> Int? {
        var numericString: String = String(self)
        numericString.removeLast()

        return Int(numericString)
    }
}
