//
//  UserData.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

final class UserData: ObservableObject {
    @Published var languages: [Language] = languageData
    @Published var currentLanguageId: Int = 0
    
    func fetchWordData(word: String, langCode: String, completion: @escaping (SavingWordState) -> (Void)) {
        
        let headers = [
            "x-rapidapi-host": "systran-systran-platform-for-language-processing-v1.p.rapidapi.com",
            "x-rapidapi-key": "f750d98c7fmsh081da5c9bb3897cp1123d4jsn8257e2380de2"
        ]
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "systran-systran-platform-for-language-processing-v1.p.rapidapi.com"
        components.path = "/resources/dictionary/lookup"
        components.queryItems = [URLQueryItem(name: "source", value: langCode),
                                 URLQueryItem(name: "target", value: deviceLanguage),
                                 URLQueryItem(name: "input", value: word)
        ]

        let request = NSMutableURLRequest(url: components.url!,
                                               cachePolicy: .useProtocolCachePolicy,
                                               timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error.debugDescription)
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                      do {
                         guard let data = data,
                            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                            let resp1 = json["outputs"] as? [[String: Any]],
                            let resp2 = resp1[0]["output"] as? [String: Any],
                            let resp3 = resp2["matches"] as? [[String: Any]] else {
                                let resultFailure: SavingWordState = .saveFailure
                                completion(resultFailure)
                                return
                            }
                            do {
                                let wordJSONData = try JSONSerialization.data(withJSONObject: resp3, options: [])
                                let wordJSONDecoder = JSONDecoder()
                                do {
                                    let wordData = try wordJSONDecoder.decode([WordData].self, from: wordJSONData)
                                    DispatchQueue.main.async {
                                        let moc = appDelegate.persistentContainer.viewContext
                                        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Language")
                                        fetchRequest.predicate = NSPredicate(format: "isCurrent = %@", NSNumber(value: true))
                                        do {
                                            let fetchedLanguages = try moc.fetch(fetchRequest)
                                            if(fetchedLanguages.count != 0) {
                                                let fetchedLanguage = fetchedLanguages[0]
                                                var fetchedWords = fetchedLanguage.value(forKey: "wordsList") as? Set<Word>
                                                let newWord = Word(sourceWord: word, wordData: Set(wordData), insertIntoManagedObjectContext: appDelegate.persistentContainer.viewContext)
                                                var duplicateFlag: Bool = false
                                                
                                                for fetchedWord in Array(fetchedWords ?? Set()) {
                                                    if(fetchedWord.sourceWord == newWord.sourceWord) {
                                                        duplicateFlag = true
                                                    }
                                                }
                                                
                                                if(!duplicateFlag) {
                                                    fetchedWords?.insert(newWord)
                                                    fetchedLanguage.setValue(fetchedWords, forKey: "wordsList")
                                                    try moc.save()
                                                    
                                                    let resultSucess: SavingWordState = .saveSuccess
                                                    completion(resultSucess)
                                                } else {
                                                    print("Word already added")
                                                    let resultFailure: SavingWordState = .duplicateSave
                                                    completion(resultFailure)
                                                }
                                                
                                            } else {
                                                print("No language found")
                                                let resultFailure: SavingWordState = .saveFailure
                                                completion(resultFailure)
                                            }
                                        } catch let error as NSError {
                                            print("Could not fetch. \(error), \(error.userInfo)")
                                            let resultFailure: SavingWordState = .saveFailure
                                            completion(resultFailure)
                                        }
                                    }
                                } catch {
                                    print("JSON Decoding Fail:", error)
                                    let resultFailure: SavingWordState = .saveFailure
                                    completion(resultFailure)
                                }
                            } catch {
                                print("JSONSerialization data error:", error)
                                let resultFailure: SavingWordState = .saveFailure
                                completion(resultFailure)
                            }
                      } catch {
                          print("JSONSerialization jsonObject error:", error)
                          let resultFailure: SavingWordState = .saveFailure
                          completion(resultFailure)
                      }
                }
            }
        })
        dataTask.resume()
    }
}
