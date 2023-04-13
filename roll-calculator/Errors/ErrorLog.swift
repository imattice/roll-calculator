//
//  ErrorHandler.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/13/21.
//

import Foundation

struct ErrorLog {
    static let shared: ErrorLog = ErrorLog()

    func recordError(class classDescription: String, function functionDescription: String, error: Error) {
        // TODO: Record error in analytics
#if DEBUG
        print(classDescription)
        print(functionDescription)
        print("Error: \(error)")
#endif
    }
    func recordError(class classDescription: String, function functionDescription: String, description errorDescription: String) {
        // TODO: Record error in analytics
#if DEBUG
        print(classDescription)
        print(functionDescription)
        print(errorDescription)
#endif
    }
    func recordError(class classDescription: String, function functionDescription: String, error: NSError) {
        // TODO: Record error in analytics
#if DEBUG
        print(classDescription)
        print(functionDescription)
        print("Error: \(error.localizedDescription)")
#endif
    }
}
