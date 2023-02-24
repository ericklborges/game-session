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
    func update(id: UUID, adding session: Session) -> Counter? {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest(id: id)

        do {
            let results = try context.fetch(fetchRequest)

            guard let cdCounter = results.first else { return nil }
            cdCounter.sessions.insert(CDSession(session: session, context: context))

            try context.save()
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
}

