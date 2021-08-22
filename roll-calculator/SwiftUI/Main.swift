//
//  Main.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

@main
struct Main: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environmentObject(Calculation())
        }
    }
}
