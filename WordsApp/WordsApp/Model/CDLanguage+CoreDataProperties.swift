//
//  CDLanguage+CoreDataProperties.swift
//  WordsApp
//
//  Created by Felipe Girardi on 23/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//
//

import Foundation
import CoreData


extension CDLanguage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLanguage> {
        return NSFetchRequest<CDLanguage>(entityName: "CDLanguage")
    }

    @NSManaged public var code: String?
    @NSManaged public var flag: String?
    @NSManaged public var id: Int16
    @NSManaged public var isChosen: Bool
    @NSManaged public var name: String?
    @NSManaged public var isCurrent: Bool
    @NSManaged public var wordsList: NSSet?

}

// MARK: Generated accessors for wordsList
extension CDLanguage {

    @objc(addWordsListObject:)
    @NSManaged public func addToWordsList(_ value: CDWord)

    @objc(removeWordsListObject:)
    @NSManaged public func removeFromWordsList(_ value: CDWord)

    @objc(addWordsList:)
    @NSManaged public func addToWordsList(_ values: NSSet)

    @objc(removeWordsList:)
    @NSManaged public func removeFromWordsList(_ values: NSSet)

}
