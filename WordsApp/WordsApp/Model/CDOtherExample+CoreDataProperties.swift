//
//  CDOtherExample+CoreDataProperties.swift
//  WordsApp
//
//  Created by Felipe Girardi on 21/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//
//

import Foundation
import CoreData


extension CDOtherExample {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDOtherExample> {
        return NSFetchRequest<CDOtherExample>(entityName: "CDOtherExample")
    }

    @NSManaged public var context: String?
    @NSManaged public var source: String?
    @NSManaged public var target: String?
    @NSManaged public var wordData: CDWordData?

}
