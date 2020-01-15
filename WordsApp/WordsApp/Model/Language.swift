//
//  Language.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct Language: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var flag: String
    var isChosen: Bool
    var wordList: [Word]
    
    init(name: String, flag: String, isChosen: Bool, wordList: [Word]) {
        self.id = name
        self.name = name
        self.flag = flag
        self.isChosen = isChosen
        self.wordList = wordList
    }
}

struct LanguageChoice: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var flag: String
    
    init(name: String, flag: String) {
        self.id = name
        self.name = name
        self.flag = flag
    }
}
