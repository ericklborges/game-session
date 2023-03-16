//
//  CDGameSession.swift
//  
//
//  Created by Erick Lozano Borges on 22/02/23.
//
//

import Foundation
import CoreData

@objc(CDGameSession)
public class CDGameSession: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    // TODO: How to work with ordered collection?
    @NSManaged public var entries: Set<CDEntry>

    @nonobjc public class func fetchRequest(id: UUID? = nil) -> NSFetchRequest<CDGameSession> {
        let fetchRequest = NSFetchRequest<CDGameSession>(entityName: "GameSession")

        if let id {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        }

        return fetchRequest
    }

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
        timestamp = Date()
    }

    convenience init(session: GameSession, context: NSManagedObjectContext!) {
        self.init(entity: Self.entity(), insertInto: context)
        self.id = session.id
        self.timestamp = session.timestamp
        self.entries = Set(session.entries.map { CDEntry(entry: $0, context: context) })
    }
}
