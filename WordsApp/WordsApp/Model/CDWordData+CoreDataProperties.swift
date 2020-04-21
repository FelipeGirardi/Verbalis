//
//  CDWordData+CoreDataProperties.swift
//  WordsApp
//
//  Created by Felipe Girardi on 21/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//
//

import Foundation
import CoreData


extension CDWordData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWordData> {
        return NSFetchRequest<CDWordData>(entityName: "CDWordData")
    }

    @NSManaged public var word: CDWord?
    @NSManaged public var otherExamples: NSSet?
    @NSManaged public var source: CDSource?
    @NSManaged public var targets: NSSet?

}

// MARK: Generated accessors for otherExamples
extension CDWordData {

    @objc(addOtherExamplesObject:)
    @NSManaged public func addToOtherExamples(_ value: CDOtherExample)

    @objc(removeOtherExamplesObject:)
    @NSManaged public func removeFromOtherExamples(_ value: CDOtherExample)

    @objc(addOtherExamples:)
    @NSManaged public func addToOtherExamples(_ values: NSSet)

    @objc(removeOtherExamples:)
    @NSManaged public func removeFromOtherExamples(_ values: NSSet)

}

// MARK: Generated accessors for targets
extension CDWordData {

    @objc(addTargetsObject:)
    @NSManaged public func addToTargets(_ value: CDTarget)

    @objc(removeTargetsObject:)
    @NSManaged public func removeFromTargets(_ value: CDTarget)

    @objc(addTargets:)
    @NSManaged public func addToTargets(_ values: NSSet)

    @objc(removeTargets:)
    @NSManaged public func removeFromTargets(_ values: NSSet)

}
