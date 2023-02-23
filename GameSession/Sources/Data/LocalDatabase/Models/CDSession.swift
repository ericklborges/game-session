//
//  Session+CoreDataClass.swift
//  
//
//  Created by Erick Lozano Borges on 22/02/23.
//
//

import Foundation
import CoreData

@objc(CDSession)
public class CDSession: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    @NSManaged public var entries: NSOrderedSet

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSession> {
        return NSFetchRequest<CDSession>(entityName: "Session")
    }

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
        timestamp = Date()
    }
}
