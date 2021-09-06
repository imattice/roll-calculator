//
//  Calculation.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/22/21.
//

import Foundation
import SwiftUI

///An object that holds values used for a particular calculation
class Calculation: ObservableObject, Identifiable {
    ///A unique identifier for the calculation
    let id: String = UUID().uuidString
    ///The calculated result for the calculation
    @Published var result: String
    ///The method that creates a result
    @Published var method: String
    
    var description: String { "You rolled a \(result)!" }
    
    ///Calculate a new result for
    @discardableResult func calculate() -> Result<Int, CalculationError> {
        let expression = NSExpression(format: method)
        guard let result = expression.expressionValue(with: nil, context: nil) as? Int else {
            return .failure(.invalidCalculation)
        }
        self.result = String(result)
        return .success(result)
    }
    
    ///Replaces the given die text with rolled values
    func rollsReplaced(_ text: String) -> String {        
        guard let matchRange = text.range(of: Regex.dieRoll.pattern, options: [.regularExpression]) else {
            return text
        }
        
        guard var roll = try? Roll(fromString: String(text[matchRange])) else {
            return text
        }
        
        let result = roll.calculate()
        
        //replace range with roll result
        let replacedText = text.replacingCharacters(in: matchRange, with: String(result))
        
        //Check for more matches recursively
        return rollsReplaced(replacedText)
    }
    
    init(method: String = "", result: String = "") {
        self.result = result
        self.method = method
    }
}

enum CalculationError: Error {
    case invalidCalculation
}
