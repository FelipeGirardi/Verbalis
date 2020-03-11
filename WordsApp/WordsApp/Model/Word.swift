//
//  Word.swift
//  WordsApp
//
//  Created by Felipe Girardi on 14/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import Foundation

// MARK: - Word
struct Word: Hashable, Codable {
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.sourceWord == rhs.sourceWord
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sourceWord)
    }
    
    let sourceWord: String
    let wordData: [WordData]
}

// MARK: - Translation
struct WordData: Hashable, Codable {
    static func == (lhs: WordData, rhs: WordData) -> Bool {
        return lhs.source == lhs.source
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(source)
    }
    
    let otherExamples: [OtherExample]?
    let source: Source?
    let targets: [Target]?

    enum CodingKeys: String, CodingKey {
        case otherExamples = "other_expressions"
        case source, targets
    }
}

// MARK: - OtherExample
struct OtherExample: Codable {
    let context, source, target: String?
}

// MARK: - Source
struct Source: Hashable, Codable {
    static func == (lhs: Source, rhs: Source) -> Bool {
        return lhs.lemma == lhs.lemma
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(lemma)
    }
    
    let inflection, info, lemma, phonetic, partOfSpeech, term: String?
    
    enum CodingKeys: String, CodingKey {
        case inflection, info, lemma, phonetic, term
        case partOfSpeech = "pos"
    }
}

// MARK: - Target
struct Target: Hashable, Codable {
    static func == (lhs: Target, rhs: Target) -> Bool {
        return lhs.translationLemma == lhs.translationLemma
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(translationLemma)
    }
    
    let context: String?
    let entryID: Int?
    let examples: [Example]?
    let info: String?
    let synonyms: [String]?
    let translationLemma, rank: String?

    enum CodingKeys: String, CodingKey {
        case context, info, rank
        case entryID = "entry_id"
        case examples = "expressions"
        case synonyms = "invmeanings"
        case translationLemma = "lemma"
    }
}

// MARK: - Example
struct Example: Codable {
    let source, target: String?
}
