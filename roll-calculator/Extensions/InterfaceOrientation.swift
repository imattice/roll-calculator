//
//  InterfaceOrientation.swift
//  roll-calculator
//
//  Created by Ike Mattice on 10/27/21.
//

import SwiftUI

// MARK: - Interface Orientation: Hashable
// Used to support OrientationPreview
// This could be removed if InterfaceOrientation conforms to Hashable in the future
extension InterfaceOrientation: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
