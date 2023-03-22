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
    private var _entries: [Entry]

    var entries: [Entry] {
        get { _entries.sorted(by: \.timestamp, using: >) }
        set { _entries = newValue }
    }

    var entriesSum: Int32 {
        _entries
            .map(\.value)
            .reduce(0, +)
    }

    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        entries: [Entry] = []
    ) {
        self.id = id
        self.timestamp = timestamp
        self._entries = entries
    }

    init(entry: Entry) {
        self.init(entries: [entry])
    }

    init(cdSession: CDGameSession) {
        self.init(
            id: cdSession.id,
            timestamp: cdSession.timestamp,
            entries: cdSession.entries.map(Entry.init)
        )
    }
}
