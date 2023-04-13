//
//  PersistenceManager.swift
//  roll-calculator
//
//  Created by Ike Mattice on 11/13/21.
//

import CoreData

struct PersistenceManager {
    static let shared: PersistenceManager = PersistenceManager()
    private let container: NSPersistentContainer
    var context: NSManagedObjectContext { container.viewContext }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "main")
        if inMemory {
            guard let firstDescription = container.persistentStoreDescriptions.first
            else {
                ErrorLog.shared.recordError(
                    class: String(describing: self),
                    function: #function,
                    description: "Failed to fetch the first description when accessing the persistence manager's descriptions")
                return
            }
            firstDescription.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error: NSError = error as NSError? {
                ErrorLog.shared.recordError(class: String(describing: PersistenceManager.self), function: #function, error: error)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

// MARK: - Preview Persistence Manager
extension PersistenceManager {
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
            ErrorLog.shared.recordError(
                class: String(describing: PersistenceManager.self),
                function: #function,
                error: error)
        }
        return result
    }()
}
