//
//  CDCounterDAO.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 24/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import CoreData

final class CDCounterDAO {

    private let context: NSManagedObjectContext

    init(_ context: NSManagedObjectContext) {
        self.context = context
    }

    @discardableResult
    func create(title: String) -> Counter? {
        let cdCounter = CDCounter(context: context)
        cdCounter.title = title
        cdCounter.sessions = []

        do {
            try context.save()
            return Counter(cdCounter: cdCounter)
        } catch let error {
            print(error)
            return nil
        }
    }

    @discardableResult
    func update(id: UUID, adding session: GameSession) -> Counter? {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest(id: id)

        do {
            let results = try context.fetch(fetchRequest)

            guard let cdCounter = results.first else { return nil }
            let newSession = CDGameSession(session: session, context: context)
            cdCounter.sessions.insert(newSession)

            try context.save()
            return Counter(cdCounter: cdCounter)
        } catch let error {
            print(error)
            return nil
        }
    }

    func get(id: UUID) -> Counter? {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest(id: id)

        do {
            guard let cdCounter = try context.fetch(fetchRequest).first else { return nil }
            return Counter(cdCounter: cdCounter)
        } catch let error {
            print(error)
            return nil
        }
    }

    func getAll() -> [Counter]? {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest()

        do {
            let cdCounters = try context.fetch(fetchRequest)
            return cdCounters.map(Counter.init)
        } catch let error {
            print(error)
            return nil
        }
    }

    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest(id: id)

        do {
            let results = try context.fetch(fetchRequest)
            guard let cdCounter = results.first else { return }

            context.delete(cdCounter)
            try context.save()

        } catch let error {
            print(error)
        }
    }

    @discardableResult
    func clearSessions(id: UUID) -> Counter? {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest(id: id)

        do {
            let results = try context.fetch(fetchRequest)

            guard let cdCounter = results.first else { return nil }
            cdCounter.sessions.forEach { context.delete($0) }

            try context.save()
            return Counter(cdCounter: cdCounter)
        } catch let error {
            print(error)
            return nil
        }
    }
}
