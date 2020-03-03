//
//  Network.swift
//  WordsApp
//
//  Created by Felipe Girardi on 28/02/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import Foundation

class Network: LocalService {
    var wordModelData: [Word] = []

    func fetchTranslations(word: String, langCode: String, completion: @escaping (Result<[Word], Error>) -> (Void)) {
        
        let headers = [
            "x-rapidapi-host": "systran-systran-platform-for-language-processing-v1.p.rapidapi.com",
            "x-rapidapi-key": "f750d98c7fmsh081da5c9bb3897cp1123d4jsn8257e2380de2"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://systran-systran-platform-for-language-processing-v1.p.rapidapi.com/resources/dictionary/lookup?source=\(langCode)&target=en&input=\(word)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                  do {
                    // MARK: create proper model from this
                      if let data = data, let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                        let resp1 = json["outputs"] as? [[String : Any]],
                        let resp2 = resp1[0]["output"] as? [String : Any],
                        let resp3 = resp2["matches"] as? [[String: Any]] {
                        do {
                            let wordJSONData = try JSONSerialization.data(withJSONObject: resp3, options: [])
                            let wordJSONDecoder = JSONDecoder()
                            do {
                                let wordData = try wordJSONDecoder.decode([Word].self, from: wordJSONData)
                                self.wordModelData = wordData
                                //print(self.wordModelData)
                            } catch {
                                print("JSON Decoding Fail")
                            }
                        } catch {
                            print("JSONSerialization data error")
                        }
                    }
                  } catch {
                      print("JSONSerialization jsonObject error:", error)
                  }
            }
            }
        })
        dataTask.resume()
        
        let resultSucess: Result<[Word], Error> = .success(wordModelData)
        completion(resultSucess)
    }

}
