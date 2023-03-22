//
//  Entry.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 24/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation
import CoreData

struct Entry: Identifiable {
    let id: UUID
    let timestamp: Date
    let value: Int32

    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        value: Int32
    ) {
        self.id = id
        self.timestamp = timestamp
        self.value = value
    }


    init(cdEntry: CDEntry) {
        self.init(
            id: cdEntry.id,
            timestamp: cdEntry.timestamp,
            value: cdEntry.value
        )
    }
}
