//
//  CDExample+CoreDataProperties.swift
//  WordsApp
//
//  Created by Felipe Girardi on 21/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//
//

import Foundation
import CoreData


extension CDExample {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExample> {
        return NSFetchRequest<CDExample>(entityName: "CDExample")
    }

    @NSManaged public var exampleSource: String?
    @NSManaged public var exampleTarget: String?
    @NSManaged public var target: CDTarget?

}
