//
//  Roll.swift
//  Roll
//
//  Created by Ike Mattice on 9/4/21.
//

///An object holding values for a particular dice roll
struct Roll {
    ///The number of dice rolled
    let count: Int
    ///The maximum value of the die
    let dieValue: Int
    ///Holds a record of each individual random number generated
    var results: [Int] = [Int]()
    ///The sum of all calculated rolls
    var result: Int { results.reduce(0, +) }
    
    ///Create a roll from a string that follows the standard die pattern
    init(fromString string: String) throws {
        guard string.matches(Regex.dieRoll.pattern) else {
            throw RollError.invalidString
        }
        
        let components = string.components(separatedBy: "d")
        
        guard let countString     = components.first,
              let count            = Int(countString) else {
                  throw RollError.invalidCount
              }
        guard let valueString            = components.last,
              let value                = Int(valueString) else {
                  throw RollError.invalidValue
              }
        
        self.count = count
        self.dieValue = value
    }
    
    ///Returns a string of the results array, joined by a "+" and surrounded by parentheses
    func resultsString() -> String {
        return "(\(results.map({ String($0) }).joined(separator: "+")))"
    }
    
    ///Calculates random numbers and fills the results with those results
    mutating func calculate() -> Int {
        results = [Int]()
        
        for _ in 1...count {
            let result = Int.random(in: 1...dieValue)
            results.append(result)
        }
                
        return result
    }
}

