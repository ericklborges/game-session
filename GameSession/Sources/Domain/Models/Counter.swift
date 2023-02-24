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
    var sessions: [Session]

    init(_ title: String) {
        self.id = UUID()
        self.title = title
        self.sessions = []
    }

    init(cdCounter: CDCounter) {
        self.id = cdCounter.id
        self.title = cdCounter.title
        self.sessions = cdCounter.sessions.map(Session.init)
    }
}
