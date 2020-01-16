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
    
    init(name: String, flag: String, isChosen: Bool) {
        self.id = name
        self.name = name
        self.flag = flag
        self.isChosen = isChosen
    }
}

struct LanguageChoice: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var flag: String
    var wordsList: [Word]
    
    init(name: String, flag: String, wordsList: [Word]) {
        self.id = name
        self.name = name
        self.flag = flag
        self.wordsList = wordsList
    }
}
