//
//  CDSource+CoreDataProperties.swift
//  WordsApp
//
//  Created by Felipe Girardi on 21/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//
//

import Foundation
import CoreData


extension CDSource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSource> {
        return NSFetchRequest<CDSource>(entityName: "CDSource")
    }

    @NSManaged public var inflection: String?
    @NSManaged public var info: String?
    @NSManaged public var lemma: String?
    @NSManaged public var partOfSpeech: String?
    @NSManaged public var phonetic: String?
    @NSManaged public var term: String?
    @NSManaged public var wordData: CDWordData?

}
