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
    
    @discardableResult func calculate() -> Result<Int, CalculationError> {
        let expression = NSExpression(format: method)
        guard let result = expression.expressionValue(with: nil, context: nil) as? Int else {
            return .failure(.invalidCalculation)
        }
        self.result = String(result)
        return .success(result)
    }
    
    init(method: String = "", result: String = "") {
        self.result = result
        self.method = method
    }
}

enum CalculationError: Error {
    case invalidCalculation
}
