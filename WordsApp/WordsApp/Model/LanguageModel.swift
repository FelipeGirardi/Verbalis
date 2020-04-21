//
//  LanguageModel.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import Foundation
import SwiftUI

let deviceLanguage: String = String(Locale.preferredLanguages.first?.prefix(2) ?? "en")

// - MARK: might change id from position to UUID later

let languageData: [Language] = [
    Language(id: 0, name: "English", flag: "🇺🇸", code: "en", isChosen: false, wordsList: []),
    Language(id: 1, name: "Spanish", flag: "🇪🇸", code: "es", isChosen: false, wordsList: []),
    Language(id: 2, name: "French", flag: "🇫🇷", code: "fr", isChosen: false, wordsList: []),
    Language(id: 3, name: "German", flag: "🇩🇪", code: "de", isChosen: false, wordsList: []),
    Language(id: 4, name: "Italian", flag: "🇮🇹", code: "it", isChosen: false, wordsList: []),
    Language(id: 5, name: "Portuguese", flag: "🇧🇷", code: "pt", isChosen: false, wordsList: []),
    Language(id: 6, name: "Russian", flag: "🇷🇺", code: "ru", isChosen: false, wordsList: [])
    ].filter { !($0.code == deviceLanguage) }
