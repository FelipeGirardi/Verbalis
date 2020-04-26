//
//  Language.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import Foundation
import CoreData

@objc(Language)
class Language: NSManagedObject, Identifiable {
    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.id == rhs.id
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Language> {
        return NSFetchRequest<Language>(entityName: "Language")
    }
    
    @NSManaged var id: Int16
    @NSManaged var name: String?
    @NSManaged var code: String?
    @NSManaged var flag: String?
    @NSManaged var isChosen: Bool
    @NSManaged var isCurrent: Bool
    @NSManaged var wordsList: Set<Word>?
    
    convenience init(id: Int16, name: String, flag: String, code: String, isChosen: Bool, isCurrent: Bool, wordsList: Set<Word>, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Language", in: context)!
        self.init(entity: entity, insertInto: context)
        self.id = id
        self.name = name
        self.code = code
        self.flag = flag
        self.isChosen = isChosen
        self.isCurrent = isCurrent
        self.wordsList = wordsList
    }
}

extension Language {

    @objc(addWordsListObject:)
    @NSManaged public func addToWordsList(_ value: Word)

    @objc(removeWordsListObject:)
    @NSManaged public func removeFromWordsList(_ value: Word)

    @objc(addWordsList:)
    @NSManaged public func addToWordsList(_ values: Set<Word>)

    @objc(removeWordsList:)
    @NSManaged public func removeFromWordsList(_ values: Set<Word>)

}
