//
//  Calculation.swift
//  roll-calculator
//
//  Created by Ike Mattice on 8/22/21.
//

import Foundation
import SwiftUI

class Calculation: ObservableObject {
    @Published var result: String = ""
    @Published var method: String = ""
}
