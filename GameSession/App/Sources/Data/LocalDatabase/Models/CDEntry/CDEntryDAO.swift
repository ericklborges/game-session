//
//  CDEntryDAO.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 23/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation
import CoreData

final class CDEntryDAO {

    private let context: NSManagedObjectContext

    init(_ context: NSManagedObjectContext) {
        self.context = context
    }

    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<CDEntry> = CDEntry.fetchRequest(id: id)

        do {
            let results = try context.fetch(fetchRequest)
            guard let cdEntry = results.first else { return }

            context.delete(cdEntry)
            try context.save()

        } catch let error {
            print(error)
        }
    }
}

