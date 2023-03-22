//
//  Counter.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 24/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation
import CoreData

struct Counter {
    let id: UUID
    let title: String
    private var _sessions: [GameSession]

    var sessions: [GameSession] {
        get { _sessions.sorted(by: \.timestamp, using: >) }
        set { _sessions = newValue }
    }

    var allSessionsEntriesSum: Int32 {
        sessions
            .map(\.entriesSum)
            .reduce(0, +)
    }

    init(
        id: UUID = UUID(),
        title: String,
        sessions: [GameSession] = []
    ) {
        self.id = id
        self.title = title
        self._sessions = sessions
    }

    init(cdCounter: CDCounter) {
        self.init(
            id: cdCounter.id,
            title: cdCounter.title,
            sessions: cdCounter.sessions.map(GameSession.init)
        )
    }
}
