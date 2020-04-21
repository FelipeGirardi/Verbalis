//
//  CDTarget+CoreDataProperties.swift
//  WordsApp
//
//  Created by Felipe Girardi on 21/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//
//

import Foundation
import CoreData


extension CDTarget {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTarget> {
        return NSFetchRequest<CDTarget>(entityName: "CDTarget")
    }

    @NSManaged public var context: String?
    @NSManaged public var entryID: String?
    @NSManaged public var info: String?
    @NSManaged public var rank: String?
    @NSManaged public var translationLemma: String?
    @NSManaged public var synonyms: [String]?
    @NSManaged public var wordData: CDWordData?
    @NSManaged public var examples: NSSet?

}

// MARK: Generated accessors for examples
extension CDTarget {

    @objc(addExamplesObject:)
    @NSManaged public func addToExamples(_ value: CDExample)

    @objc(removeExamplesObject:)
    @NSManaged public func removeFromExamples(_ value: CDExample)

    @objc(addExamples:)
    @NSManaged public func addToExamples(_ values: NSSet)

    @objc(removeExamples:)
    @NSManaged public func removeFromExamples(_ values: NSSet)

}
