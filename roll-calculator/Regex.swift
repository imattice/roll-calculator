//
//  Regex.swift
//  Regex
//
//  Created by Ike Mattice on 9/4/21.
//

import Foundation

///Options for regex patterns
enum Regex {
    ///The pattren for dice rolls; e.g. "10d20'
    case dieRoll
    
    ///The stirng pattern for the selected regex option
    var pattern: String {
        switch self {
        case .dieRoll: return #"\d+d\d+"#
        }
    }
}
