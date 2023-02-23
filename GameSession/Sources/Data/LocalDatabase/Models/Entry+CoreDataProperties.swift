//
//  Entry+CoreDataProperties.swift
//  
//
//  Created by Erick Lozano Borges on 22/02/23.
//
//

import Foundation
import CoreData


extension CDEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    

}
