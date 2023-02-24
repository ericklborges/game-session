//
//  Session.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 24/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation
import CoreData

struct Session {
    let id: UUID
    let timestamp: Date
    var entries: [Entry]

    init(entry: Entry) {
        self.id = UUID()
        self.timestamp = Date()
        self.entries = [entry]
    }

    init(cdSession: CDSession) {
        self.id = cdSession.id
        self.timestamp = cdSession.timestamp
        self.entries = cdSession.entries.map(Entry.init)
    }
}
