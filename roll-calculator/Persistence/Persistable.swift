//
//  Persistable.swift
//  roll-calculator
//
//  Created by Ike Mattice on 12/12/21.
//

import CoreData

/// Describes an object that can be persisted to Core Data
protocol Persistable {
    associatedtype Record

    /// Saves the object to CoreData
    func save(to context: NSManagedObjectContext)
}

extension Persistable where Self: Identifiable {
    /// Deletes the object from CoreData
    func delete(in context: NSManagedObjectContext = PersistenceManager.shared.context) {
        if let existingRecord: NSManagedObject = fetchRecord(from: context) {
            context.delete(existingRecord)
        }
    }

    /// Fetches the specific backing data record for the calling object based on its id property
    func fetchRecord(from context: NSManagedObjectContext = PersistenceManager.shared.context) -> NSManagedObject? {
        guard let objectId = id as? UUID else {
            ErrorLog.shared.recordError(
                class: String(describing: self),
                function: #function,
                description: "Attempted to fetch \(String(describing: self)) records with invalid ID type: \(String(describing: type(of: id)))")
            return nil
        }

        let request: NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: String(describing: Record.self))
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id LIKE %@", objectId.uuidString)

        do {
            return try context.fetch(request).first
        } catch {
            // TODO: Handle Error
        }

        return nil
    }
}
