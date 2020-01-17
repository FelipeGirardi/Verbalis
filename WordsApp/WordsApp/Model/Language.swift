//
//  Language.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct Language: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var flag: String
    var isChosen: Bool
    var wordsList: [Word]
    
    init(id: Int, name: String, flag: String, isChosen: Bool, wordsList: [Word]) {
        self.id = id
        self.name = name
        self.flag = flag
        self.isChosen = isChosen
        self.wordsList = wordsList
    }
}

//struct LanguageChoice: Hashable, Codable, Identifiable {
//    var id: Int
//    var name: String
//    var flag: String
//    var wordsList: [Word]
//    
//    init(id: Int, name: String, flag: String, wordsList: [Word]) {
//        self.id = id
//        self.name = name
//        self.flag = flag
//        self.wordsList = wordsList
//    }
//}
