//
//  CDSessionDAO.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 24/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation
import CoreData

final class CDSessionDAO {

    private let context: NSManagedObjectContext

    init(_ context: NSManagedObjectContext) {
        self.context = context
    }

    @discardableResult
    func create(entry: Entry? = nil) -> GameSession? {
        let cdSession = CDGameSession(context: context)

        if let entry {
            cdSession.entries = [CDEntry(entry: entry, context: context)]
        } else {
            cdSession.entries = []
        }

        do {
            try context.save()
            return GameSession(cdSession: cdSession)
        } catch let error {
            print(error)
            return nil
        }
    }

    @discardableResult
    func update(id: UUID, adding entry: Entry) -> GameSession? {
        let fetchRequest: NSFetchRequest<CDGameSession> = CDGameSession.fetchRequest(id: id)

        do {
            let results = try context.fetch(fetchRequest)

            guard let cdSession = results.first else { return nil }
            cdSession.entries.insert(CDEntry(entry: entry, context: context))

            try context.save()
            return GameSession(cdSession: cdSession)
        } catch let error {
            print(error)
            return nil
        }
    }
}

