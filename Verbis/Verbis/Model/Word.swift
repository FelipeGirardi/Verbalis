//
//  Word.swift
//  WordsApp
//
//  Created by Felipe Girardi on 14/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "managedObjectContext")
}

// MARK: - Word
@objc(Word)
class Word: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.sourceWord == rhs.sourceWord
    }
    
    @NSManaged var sourceWord: String?
    @NSManaged var wordData: Set<WordData>?
    
    enum CodingKeys: String, CodingKey {
       case sourceWord, wordData
    }
    
    convenience init(sourceWord: String, wordData: Set<WordData>, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Word", in: context)!
        self.init(entity: entity, insertInto: context)
        self.sourceWord = sourceWord
        self.wordData = wordData
    }
    
//    required convenience init(from decoder: Decoder) throws {
//        guard let entity = NSEntityDescription.entity(forEntityName: "Word", in: appContext) else {
//            fatalError("Failed to decode Word")
//        }
//        self.init(entity: entity, insertInto: appContext)
//        
//        // Decode
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        sourceWord = try values.decode(String.self, forKey: .sourceWord)
//        let wordDataArray = try values.decode([WordData].self, forKey: .wordData)
//        wordData = Set(wordDataArray)
//    }
    
    // Encode
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(sourceWord, forKey: .sourceWord)
//        let wordDataArray = Array(wordData ?? Set())
//        try container.encode(wordDataArray, forKey: .wordData)
//    }
    
}

extension Word {

    @objc(addWordDataObject:)
    @NSManaged public func addToWordData(_ value: WordData)

    @objc(removeWordDataObject:)
    @NSManaged public func removeFromWordData(_ value: WordData)

    @objc(addWordData:)
    @NSManaged public func addToWordData(_ values: Set<WordData>)

    @objc(removeWordData:)
    @NSManaged public func removeFromWordData(_ values: Set<WordData>)

}


// MARK: - WordData
@objc(WordData)
class WordData: NSManagedObject, Codable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordData> {
        return NSFetchRequest<WordData>(entityName: "WordData")
    }
    
    static func == (lhs: WordData, rhs: WordData) -> Bool {
        return lhs.source?.lemma == rhs.source?.lemma
    }
    
    @NSManaged var otherExamples: Set<OtherExample>?
    @NSManaged var source: SourceData?
    @NSManaged var targets: Set<TargetData>?
    @NSManaged var isMainWord: NSNumber?

    enum CodingKeys: String, CodingKey {
        case otherExamples = "other_expressions"
        case source, targets, isMainWord
    }
    
    convenience init(otherExamples: Set<OtherExample>, source: SourceData, targets: Set<TargetData>, isMainWord: NSNumber, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "WordData", in: context)!
        self.init(entity: entity, insertInto: context)
        self.otherExamples = otherExamples
        self.source = source
        self.targets = targets
        self.isMainWord = isMainWord
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "WordData", in: appContext) else {
            fatalError("Failed to decode WordData")
        }
        self.init(entity: entity, insertInto: appContext)
        
        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let otherExamplesArray = try? values.decodeIfPresent([OtherExample].self, forKey: .otherExamples) {
            otherExamples = Set(otherExamplesArray)
        } else {
            otherExamples = Set()
        }
        source = try values.decode(SourceData.self, forKey: .source)
        let targetsArray = try values.decode([TargetData].self, forKey: .targets)
        targets = Set(targetsArray)
    }
    
    // Encode
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let otherExamplesArray = Array(otherExamples ?? Set())
        try container.encode(otherExamplesArray, forKey: .otherExamples)
        try container.encode(source, forKey: .source)
        let targetsArray = Array(targets ?? Set())
        try container.encode(targetsArray, forKey: .targets)
    }
}

extension WordData {

    @objc(addOtherExamplesObject:)
    @NSManaged public func addToOtherExamples(_ value: OtherExample)

    @objc(removeOtherExamplesObject:)
    @NSManaged public func removeFromOtherExamples(_ value: OtherExample)

    @objc(addOtherExamples:)
    @NSManaged public func addToOtherExamples(_ values: Set<OtherExample>)

    @objc(removeOtherExamples:)
    @NSManaged public func removeFromOtherExamples(_ values: Set<OtherExample>)

}

extension WordData {

    @objc(addTargetsObject:)
    @NSManaged public func addToTargets(_ value: TargetData)

    @objc(removeTargetsObject:)
    @NSManaged public func removeFromTargets(_ value: TargetData)

    @objc(addTargets:)
    @NSManaged public func addToTargets(_ values: Set<TargetData>)

    @objc(removeTargets:)
    @NSManaged public func removeFromTargets(_ values: Set<TargetData>)

}


// MARK: - OtherExample
@objc(OtherExample)
class OtherExample: NSManagedObject, Codable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<OtherExample> {
        return NSFetchRequest<OtherExample>(entityName: "OtherExample")
    }
    
    static func == (lhs: OtherExample, rhs: OtherExample) -> Bool {
        return lhs.source == rhs.source
    }
    
    @NSManaged var exampleContext, source, target: String?
    
    enum CodingKeys: String, CodingKey {
        case exampleContext = "context"
        case source, target
    }
    
    convenience init(exampleContext: String, source: String, target: String, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "WordData", in: context)!
        self.init(entity: entity, insertInto: context)
        self.exampleContext = exampleContext
        self.source = source
        self.target = target
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "OtherExample", in: appContext) else {
            fatalError("Failed to decode OtherExamples")
        }
        self.init(entity: entity, insertInto: appContext)
        
        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)
        exampleContext = try values.decode(String.self, forKey: .exampleContext)
        source = try values.decode(String.self, forKey: .source)
        target = try values.decode(String.self, forKey: .target)
    }
    
    // Encode
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(exampleContext, forKey: .exampleContext)
        try container.encode(source, forKey: .source)
        try container.encode(target, forKey: .target)
    }
    
}


// MARK: - Source
@objc(SourceData)
class SourceData: NSManagedObject, Codable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceData> {
        return NSFetchRequest<SourceData>(entityName: "SourceData")
    }
    
    static func == (lhs: SourceData, rhs: SourceData) -> Bool {
        return lhs.lemma == lhs.lemma
    }
    
    @NSManaged public var inflection: String?
    @NSManaged public var info: String?
    @NSManaged public var lemma: String?
    @NSManaged public var partOfSpeech: String?
    @NSManaged public var phonetic: String?
    @NSManaged public var term: String?
    
    enum CodingKeys: String, CodingKey {
        case inflection, info, lemma, phonetic, term
        case partOfSpeech = "pos"
    }
    
    convenience init(inflection: String, info: String, lemma: String, partOfSpeech: String, phonetic: String, term: String, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "SourceData", in: context)!
        self.init(entity: entity, insertInto: context)
        self.inflection = inflection
        self.info = info
        self.lemma = lemma
        self.partOfSpeech = partOfSpeech
        self.phonetic = phonetic
        self.term = term
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "SourceData", in: appContext) else {
            fatalError("Failed to decode SourceData")
        }
        self.init(entity: entity, insertInto: appContext)
        
        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)
        inflection = try values.decode(String.self, forKey: .inflection)
        info = try values.decode(String.self, forKey: .info)
        lemma = try values.decode(String.self, forKey: .lemma)
        partOfSpeech = try values.decode(String.self, forKey: .partOfSpeech)
        phonetic = try values.decode(String.self, forKey: .phonetic)
        term = try values.decode(String.self, forKey: .term)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(inflection, forKey: .inflection)
        try container.encode(info, forKey: .info)
        try container.encode(lemma, forKey: .lemma)
        try container.encode(partOfSpeech, forKey: .partOfSpeech)
        try container.encode(phonetic, forKey: .phonetic)
        try container.encode(term, forKey: .term)
    }
}


// MARK: - Target
@objc(TargetData)
class TargetData: NSManagedObject, Codable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TargetData> {
        return NSFetchRequest<TargetData>(entityName: "TargetData")
    }
    
    static func == (lhs: TargetData, rhs: TargetData) -> Bool {
        return lhs.translationLemma == lhs.translationLemma
    }
    
    @NSManaged public var targetContext: String?
    @NSManaged public var info: String?
    @NSManaged public var rank: String?
    @NSManaged public var translationLemma: String?
    @NSManaged public var synonyms: [String]?
    @NSManaged public var examples: Set<Example>?

    enum CodingKeys: String, CodingKey {
        case targetContext = "context"
        case info, rank
        case examples = "expressions"
        case synonyms = "invmeanings"
        case translationLemma = "lemma"
    }
    
    convenience init(targetContext: String, info: String, rank: String, translationLemma: String, synonyms: [String], examples: Set<Example>, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "TargetData", in: context)!
        self.init(entity: entity, insertInto: context)
        self.targetContext = targetContext
        self.info = info
        self.rank = rank
        self.translationLemma = translationLemma
        self.synonyms = synonyms
        self.examples = examples
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "TargetData", in: appContext) else {
            fatalError("Failed to decode TargetData")
        }
        self.init(entity: entity, insertInto: appContext)
        
        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)
        targetContext = try values.decode(String.self, forKey: .targetContext)
        info = try values.decode(String.self, forKey: .info)
        rank = try values.decode(String.self, forKey: .rank)
        translationLemma = try values.decode(String.self, forKey: .translationLemma)
        synonyms = try values.decode([String].self, forKey: .synonyms)
        if let examplesArray = try? values.decodeIfPresent([Example].self, forKey: .examples) {
            examples = Set(examplesArray)
        } else {
            examples = Set()
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(targetContext, forKey: .targetContext)
        try container.encode(info, forKey: .info)
        try container.encode(rank, forKey: .rank)
        try container.encode(translationLemma, forKey: .translationLemma)
        try container.encode(synonyms, forKey: .synonyms)
        let examplesArray = Array(examples ?? Set())
        try container.encode(examplesArray, forKey: .examples)
    }
}

extension TargetData {

    @objc(addExamplesObject:)
    @NSManaged public func addToExamples(_ value: Example)

    @objc(removeExamplesObject:)
    @NSManaged public func removeFromExamples(_ value: Example)

    @objc(addExamples:)
    @NSManaged public func addToExamples(_ values: Set<Example>)

    @objc(removeExamples:)
    @NSManaged public func removeFromExamples(_ values: Set<Example>)

}


// MARK: - Example
@objc(Example)
class Example: NSManagedObject, Codable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Example> {
        return NSFetchRequest<Example>(entityName: "Example")
    }
    
    @NSManaged var exampleSource, exampleTarget: String?
    
    enum CodingKeys: String, CodingKey {
        case exampleSource = "source"
        case exampleTarget = "target"
    }
    
    convenience init(exampleSource: String, exampleTarget: String, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Example", in: context)!
        self.init(entity: entity, insertInto: context)
        self.exampleSource = exampleSource
        self.exampleTarget = exampleTarget
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Example", in: appContext) else {
            fatalError("Failed to decode Example")
        }
        self.init(entity: entity, insertInto: appContext)
        
        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)
        exampleSource = try values.decode(String.self, forKey: .exampleSource)
        exampleTarget = try values.decode(String.self, forKey: .exampleTarget)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(exampleSource, forKey: .exampleSource)
        try container.encode(exampleSource, forKey: .exampleTarget)
    }
}
