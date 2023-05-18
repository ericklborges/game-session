//
//  Entry.swift
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

public struct Entry: Identifiable {
    public let id: UUID
    public let timestamp: GSDate
    public let value: Int32

    public init(
        id: UUID = UUID(),
        timestamp: GSDate = .today,
        value: Int32
    ) {
        self.id = id
        self.timestamp = timestamp
        self.value = value
    }


    init(cdEntry: CDEntry) {
        self.init(
            id: cdEntry.id,
            timestamp: GSDate(cdEntry.timestamp),
            value: cdEntry.value
        )
    }
}
