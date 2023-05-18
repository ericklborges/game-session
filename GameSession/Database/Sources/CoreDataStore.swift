//
//  CoreDataStore.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 23/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import CoreData

public final class CoreDataStore {

    public static let shared = CoreDataStore()

    private init() {}

    // MARK: - Database References
    private lazy var container = NSPersistentCloudKitContainer(
        name: "GameSession",
        managedObjectModel: managedObjectModel
    )

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let url = Bundle.module.url(forResource: "GameSession", withExtension: "momd") else {
            fatalError("Could not find URL for CoreData model named \"GameSession\"")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Could not find CoreData for url: \(url)")
        }
        return model
    }()


    public var context: NSManagedObjectContext { container.viewContext }

    // MARK: - Life Cycle
    public func loadStore(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions = [makeStoreInMemoryDescription()]
        }

        container.loadPersistentStores { description, error in
            guard let error else { return }
            fatalError("Unable to load persistent stores: \(error)")
        }

        setupCloudkitSchema()
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

private extension CoreDataStore {
    private func setupCloudkitSchema() {
        #if DEBUG
        do {
            try container.initializeCloudKitSchema(options: [])
        } catch {
            print(error)
        }
        #endif
    }
}

