//
//  LocalService.swift
//  WordsApp
//
//  Created by Felipe Girardi on 28/02/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import Foundation

protocol LocalService {
    func fetchTranslations(word: String, langCode: String, completion: @escaping (Result<[Word], Error>) -> (Void))
}
