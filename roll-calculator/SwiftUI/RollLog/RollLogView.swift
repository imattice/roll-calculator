//
//  RollLogView.swift
//  roll-calculator
//
//  Created by Ike Mattice on 9/2/21.
//

import SwiftUI

struct RollLogView: View {
    let rollLog: RollLog

    var body: some View {
        List(rollLog.calculations) { calc in
            Text("You rolled a \(calc.result?.value ?? 0)!")
        }
    }

    init(rollLog: RollLog = RollLog.shared) {
        self.rollLog = rollLog
    }
}

struct RollLogView_Previews: PreviewProvider {
    static let rollLog: RollLog = RollLog(calculations: [
        Calculation(
            method: Calculation.Method(
                components: [
                    .standardDie(roll: Roll(dieValue: 4))
                ])),
        Calculation(
            method: Calculation.Method(
                components: [
                    .numeral(value: 1),
                    .operand(value: .add),
                    .standardDie(roll: Roll(count: 1, dieValue: 6))
                ])),
        Calculation(
            method: Calculation.Method(
                components: [
                    .standardDie(roll: Roll(dieValue: 100))
                ]))
    ])

    static var previews: some View {
        RollLogView(rollLog: rollLog)
    }
}
