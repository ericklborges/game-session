//
//  CDEntry.swift
//  
//
//  Created by Erick Lozano Borges on 22/02/23.
//
//

import Foundation
import CoreData

@objc(CDEntry)
public class CDEntry: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    @NSManaged public var value: Int32

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEntry> {
        return NSFetchRequest<CDEntry>(entityName: "Entry")
    }

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
        timestamp = Date()
    }

    convenience init(entry: Entry, context: NSManagedObjectContext!) {
        self.init(entity: Self.entity(), insertInto: context)
        self.id = entry.id
        self.timestamp = entry.timestamp
        self.value = entry.value
    }
}
