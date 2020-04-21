//
//  CDWord+CoreDataProperties.swift
//  WordsApp
//
//  Created by Felipe Girardi on 21/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//
//

import Foundation
import CoreData


extension CDWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWord> {
        return NSFetchRequest<CDWord>(entityName: "CDWord")
    }

    @NSManaged public var sourceWord: String?
    @NSManaged public var id: UUID?
    @NSManaged public var wordData: NSSet?
    @NSManaged public var language: CDLanguage?

}

// MARK: Generated accessors for wordData
extension CDWord {

    @objc(addWordDataObject:)
    @NSManaged public func addToWordData(_ value: CDWordData)

    @objc(removeWordDataObject:)
    @NSManaged public func removeFromWordData(_ value: CDWordData)

    @objc(addWordData:)
    @NSManaged public func addToWordData(_ values: NSSet)

    @objc(removeWordData:)
    @NSManaged public func removeFromWordData(_ values: NSSet)

}
