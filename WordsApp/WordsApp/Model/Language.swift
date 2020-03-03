//
//  Language.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI
import Foundation

struct Language: Hashable, Codable, Identifiable {
    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int
    var name: String
    var code: String
    var flag: String
    var isChosen: Bool
    var wordsList: [Word]
    
    init(id: Int, name: String, flag: String, code: String, isChosen: Bool, wordsList: [Word]) {
        self.id = id
        self.name = name
        self.code = code
        self.flag = flag
        self.isChosen = isChosen
        self.wordsList = wordsList
    }
}
