//
//  CDEntry.swift
//  
//
//  Created by Erick Lozano Borges on 22/02/23.
//
//

#if os(iOS)
import Core_iOS
#elseif os(watchOS)
import Core_watchOS
#endif
import CoreData

@objc(CDEntry)
public class CDEntry: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    @NSManaged public var value: Int32

    @nonobjc public class func fetchRequest(id: UUID? = nil) -> NSFetchRequest<CDEntry> {
        let fetchRequest = NSFetchRequest<CDEntry>(entityName: "Entry")

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

    convenience init(entry: Entry, context: NSManagedObjectContext!) {
        self.init(entity: Self.entity(), insertInto: context)
        self.id = entry.id
        self.timestamp = entry.timestamp.rawValue
        self.value = entry.value
    }
}
