//
//  Entry.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 24/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation
import CoreData

struct Entry {
    let id: UUID
    let timestamp: Date
    let value: Int32

    init(value: Int32) {
        self.id = UUID()
        self.timestamp = Date()
        self.value = value
    }

    init(cdEntry: CDEntry) {
        self.id = cdEntry.id
        self.timestamp = cdEntry.timestamp
        self.value = cdEntry.value
    }
}
