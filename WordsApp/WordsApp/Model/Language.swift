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
    
    init(id: Int, name: String, flag: String, isChosen: Bool) {
        self.id = id
        self.name = name
        self.flag = flag
        self.isChosen = isChosen
    }
}
