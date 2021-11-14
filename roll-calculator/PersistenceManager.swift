//
//  PersistenceManager.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/13/21.
//

import CoreData

struct PersistenceManager {
    static let shared: PersistenceManager = PersistenceManager()

    /// Persisted objects used for SwiftUI Previews
    static var preview: PersistenceManager = {
        let result: PersistenceManager = PersistenceManager(inMemory: true)
        let viewContext: NSManagedObjectContext = result.container.viewContext
        for _ in 0..<10 {
            // TODO: Initialize test data
        }
        do {
            try viewContext.save()
        } catch {
            ErrorHandler.shared.recordError(
                class: String(describing: PersistenceManager.self),
                function: #function,
                error: error)
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "main")
        if inMemory {
            guard let firstDescription = container.persistentStoreDescriptions.first
            else {
                ErrorHandler.shared.recordError(
                    class: String(describing: self),
                    function: #function,
                    description: "Failed to fetch the first description when accessing the persistence manager's descriptions")
                return
            }
            firstDescription.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error: NSError = error as NSError? {
                ErrorHandler.shared.recordError(class: String(describing: PersistenceManager.self), function: #function, error: error)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
