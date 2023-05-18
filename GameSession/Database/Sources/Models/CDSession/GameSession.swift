//
//  GameSession.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 24/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

#if os(iOS)
import Core_iOS
#elseif os(watchOS)
import Core_watchOS
#endif
import CoreData

public struct GameSession {
    public let id: UUID
    public let timestamp: GSDate
    private var _entries: [Entry]

    public var entries: [Entry] {
        get { _entries.sorted(by: \.timestamp, using: >) }
        set { _entries = newValue }
    }

    public var entriesSum: Int32 {
        _entries
            .map(\.value)
            .reduce(0, +)
    }

    public init(
        id: UUID = UUID(),
        timestamp: GSDate = .today,
        entries: [Entry] = []
    ) {
        self.id = id
        self.timestamp = timestamp
        self._entries = entries
    }

    public init(entry: Entry) {
        self.init(entries: [entry])
    }

    init(cdSession: CDGameSession) {
        self.init(
            id: cdSession.id,
            timestamp: GSDate(cdSession.timestamp),
            entries: cdSession.entries.map(Entry.init)
        )
    }
}
