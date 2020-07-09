//
//  LanguageModel.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import Foundation
import SwiftUI

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let appContext = appDelegate.persistentContainer.viewContext
let deviceLanguage: String = String(Locale.preferredLanguages.first?.prefix(2) ?? "en")

enum SavingWordState {
    case none
    case saving
    case saveSuccess
    case saveFailure
    case duplicateSave
}

// - MARK: might change id from position to UUID later

let languageData: [Language] = [
    Language(id: 0, name: NSLocalizedString("English", comment: "English language"), flag: "🇺🇸", code: "en", isChosen: false, isCurrent: false, wordsList: Set(), insertIntoManagedObjectContext: appDelegate.persistentContainer.viewContext),
    Language(id: 1, name: NSLocalizedString("Spanish", comment: "Spanish language"), flag: "🇪🇸", code: "es", isChosen: false, isCurrent: false, wordsList: Set(), insertIntoManagedObjectContext: appDelegate.persistentContainer.viewContext),
    Language(id: 2, name: NSLocalizedString("French", comment: "French language"), flag: "🇫🇷", code: "fr", isChosen: false, isCurrent: false, wordsList: Set(), insertIntoManagedObjectContext: appDelegate.persistentContainer.viewContext),
    Language(id: 3, name: NSLocalizedString("German", comment: "German language"), flag: "🇩🇪", code: "de", isChosen: false, isCurrent: false, wordsList: Set(), insertIntoManagedObjectContext: appDelegate.persistentContainer.viewContext),
    Language(id: 4, name: NSLocalizedString("Italian", comment: "Italian language"), flag: "🇮🇹", code: "it", isChosen: false, isCurrent: false, wordsList: Set(), insertIntoManagedObjectContext: appDelegate.persistentContainer.viewContext),
    Language(id: 5, name: NSLocalizedString("Portuguese", comment: "Portuguese language"), flag: "🇧🇷", code: "pt", isChosen: false, isCurrent: false, wordsList: Set(), insertIntoManagedObjectContext: appDelegate.persistentContainer.viewContext),
    Language(id: 6, name: NSLocalizedString("Russian", comment: "Russian language"), flag: "🇷🇺", code: "ru", isChosen: false, isCurrent: false, wordsList: Set(), insertIntoManagedObjectContext: appDelegate.persistentContainer.viewContext)
    ].filter { !($0.code == deviceLanguage) }
