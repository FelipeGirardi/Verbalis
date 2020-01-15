//
//  Word.swift
//  WordsApp
//
//  Created by Felipe Girardi on 14/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct Word: Hashable, Codable, Identifiable {
    var id: String
    var wordString: String
    var translations: [String]
    var synonyms: [String]
    var sentences: [String]
    
    init(wordString: String, translations: [String], synonyms: [String], sentences: [String]) {
        self.id = wordString
        self.wordString = wordString
        self.translations = translations
        self.synonyms = synonyms
        self.sentences = sentences
    }
}
