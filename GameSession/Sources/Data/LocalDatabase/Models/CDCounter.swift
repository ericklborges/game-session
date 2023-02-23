//
//  Counter+CoreDataClass.swift
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
    @NSManaged public var name: String
    @NSManaged public var sessions: NSOrderedSet

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCounter> {
        return NSFetchRequest<CDCounter>(entityName: "Counter")
    }

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
