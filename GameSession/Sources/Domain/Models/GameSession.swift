//
//  GameSession.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 24/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation
import CoreData

struct GameSession {
    let id: UUID
    let timestamp: Date
    var entries: [Entry]

    init(entry: Entry) {
        self.init(entries: [entry])
    }

    init(timestamp: Date = Date(), entries: [Entry]) {
        self.id = UUID()
        self.timestamp = timestamp
        self.entries = entries
    }

    init(cdSession: CDGameSession) {
        self.id = cdSession.id
        self.timestamp = cdSession.timestamp
        self.entries = cdSession.entries.map(Entry.init)
    }
}