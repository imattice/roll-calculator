//
//  PersistenceManagerTests.swift
//  roll-calculatorTests
//
//  Created by Ike Mattice on 12/12/21.
//

import XCTest

@testable import roll_calculator
import CoreData

class PersistenceManagerTests: XCTestCase {
    let persistenceManager: PersistenceManager = PersistenceManager(inMemory: true)

    func testActionCRUD() {
        guard let calculation = Calculation(from: "1d4") else {
            XCTFail("Invalid Calculation")
            return
        }
        let testAction: Action = Action(name: "Attack", calculation: calculation)

        var fetched: [ActionRecord] {
            do {
                let request: NSFetchRequest = NSFetchRequest<ActionRecord>(entityName: String(describing: ActionRecord.self))

                return try persistenceManager.context.fetch(request)
            } catch {
                XCTFail("Failed fetch for \(String(describing: ActionRecord.self))")
                return [ActionRecord]()
            }
        }

        testAction.save(to: persistenceManager.context)

        // Test Save
        XCTAssertTrue(fetched.isEmpty == false)

        testAction.delete(in: persistenceManager.context)

        // TEst Delete
        XCTAssertTrue(fetched.isEmpty == true)
    }
}
