//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Angel Vázquez on 21/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
