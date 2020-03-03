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
        return lhs.sourceWord.lowercased() == rhs.sourceWord.lowercased()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sourceWord.lowercased())
    }
    
    let sourceWord: String
    let wordData: [WordData]
}

// MARK: - Translation
struct WordData: Codable {
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
struct Source: Codable {
    let inflection, info, lemma, phonetic, partOfSpeech, term: String?
    
    enum CodingKeys: String, CodingKey {
        case inflection, info, lemma, phonetic, term
        case partOfSpeech = "pos"
    }
}

// MARK: - Target
struct Target: Codable {
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
