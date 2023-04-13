//
//  Record.swift
//  roll-calculator
//
//  Created by Ike Mattice on 12/12/21.
//

import CoreData

/// Describes an NSManagedObject that can be converted to an associated type
protocol Record: NSManagedObject {
    associatedtype Persistable

    /// Converts the record type into the associated type
    func hydrate() -> Persistable
}
