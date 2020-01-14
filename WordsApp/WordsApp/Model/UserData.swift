//
//  UserData.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var languages = languageData
    @Published var currentLanguageId = -1
    @Published var chosenLanguagesIds = []
    @Published var notChosenLanguagesIds = []
}
