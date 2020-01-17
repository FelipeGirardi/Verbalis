//
//  Word.swift
//  WordsApp
//
//  Created by Felipe Girardi on 14/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct Word: Hashable, Codable, Identifiable {
    var id: Int
    var wordString: String
    var translations: [String]
    var synonyms: [String]
    var sentences: [String]
    
    init(id: Int, wordString: String, translations: [String], synonyms: [String], sentences: [String]) {
        self.id = id
        self.wordString = wordString
        self.translations = translations
        self.synonyms = synonyms
        self.sentences = sentences
    }
}
