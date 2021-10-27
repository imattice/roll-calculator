//
//  String.swift
//  String
//
//  Created by Ike Mattice on 9/4/21.
//

import Foundation

extension String {
    /// Checks that the string matches the given regex pattern
    func matches(_ regex: String) -> Bool {
        self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
