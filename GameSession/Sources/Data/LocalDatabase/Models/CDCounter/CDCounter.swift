//
//  CDCounter.swift
//  
//
//  Created by Erick Lozano Borges on 22/02/23.
//
//

import Foundation
import CoreData

@objc(CDCounter)
public class CDCounter: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var sessions: Set<CDGameSession>

    @nonobjc public class func fetchRequest(id: UUID? = nil) -> NSFetchRequest<CDCounter> {
        let fetchRequest = NSFetchRequest<CDCounter>(entityName: "Counter")

        if let id {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        }

        return fetchRequest
    }

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }

    convenience init(counter: Counter, context: NSManagedObjectContext!) {
        self.init(entity: Self.entity(), insertInto: context)
        self.id = counter.id
        self.title = counter.title
        self.sessions = Set(counter.sessions.map { CDGameSession(session: $0, context: context) })
    }
}
