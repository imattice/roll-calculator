//
//  Calculation.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/22/21.
//

import Foundation
import SwiftUI

class Calculation: ObservableObject, Identifiable {
    let id: String = UUID().uuidString
    @Published var result: String
    @Published var method: String
    
    var description: String { "You rolled a \(result)!" }
    
    init(method: String = "", result: String = "") {
        self.result = result
        self.method = method
    }
}
