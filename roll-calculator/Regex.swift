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
    /// The pattern for a specific die roll, excluding any enclosing parenthesis
    case specificRoll(_ dieValue: Int)

    /// The stirng pattern for the selected regex option
    var pattern: String {
        switch self {
        case .dieRoll:
            return #"\b\d+d\d+\b"#
        case .specificRoll(let dieValue):
            return #"\b[(]?\d+d\#(dieValue)[)]?\b"#
        }
    }
}
