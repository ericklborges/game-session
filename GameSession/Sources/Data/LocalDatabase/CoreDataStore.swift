//
//  CoreDataStore.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 23/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import CoreData

final class CoreDataStore {

    static let shared = CoreDataStore()

    private init() {}

    // MARK: - Database References
    private lazy var container = NSPersistentContainer(name: "GameSession")

    var context: NSManagedObjectContext { container.viewContext }

    // MARK: - Life Cycle
    func loadStore(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions = [makeStoreInMemoryDescription()]
        }

        container.loadPersistentStores { description, error in
            guard let error else { return }
            fatalError("Unable to load persistent stores: \(error)")
        }
    }

    private func removeReferencesToStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }

    // MARK: - Helpers
    private func makeStoreInMemoryDescription() -> NSPersistentStoreDescription {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        return description
    }
}
