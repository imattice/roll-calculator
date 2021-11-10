//
//  Regex.swift
//  Regex
//
//  Created by Ike Mattice on 9/4/21.
//

import Foundation

/// Options for regex patterns
enum Regex {
    /// Matches the pattern for any die roll
    case dieRoll
    /// The pattern for a specific die roll, including any enclosing parenthesis
    case specificRoll(_ dieValue: Int)

    /// The stirng pattern for the selected regex option
    var pattern: String {
        switch self {
        case .dieRoll:
            return #"\b\d+d\d+\b"#
        case .specificRoll(let dieValue):
            // (?<=\s|^) lookback to match the start of the string or a space
            // (?=\s|$) lookahead to match a space or the end of string
            // [(]? captures the optional parenthesis
            return #"(?<=\s|^)[(]?\d+d\#(dieValue)[)]?(?=\s|$)"#
        }
    }
}
