//
//  WordListItem.swift
//  WordsApp
//
//  Created by Felipe Girardi on 28/05/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct WordListItem: View {
    var word: Word
    
    var wordDataArray: [WordData] {
        Array(word.wordData ?? Set()).sorted(by: {
            if $0.isMainWord?.boolValue ?? true && $1.isMainWord?.boolValue ?? true {
                return $0.targets?.count ?? 1 > $1.targets?.count ?? 1
            } else {
                return $0.isMainWord?.boolValue ?? true && !($1.isMainWord?.boolValue ?? true)
            }
        } )
    }
    
    var firstWordTargets: [TargetData] {
        Array(wordDataArray[0].targets ?? Set()).sorted(by: { $0.rank ?? "" < $1.rank ?? "" } )
    }
    
    var translationsString: String {
        var tempString: String = ""
        for target in firstWordTargets {
            tempString.append(contentsOf: (target.translationLemma ?? "") + ", ")
        }
        tempString = String(tempString.dropLast(2))
        return tempString
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("MetallicBlue"))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Main"), lineWidth: 2)
                        .blur(radius: 4)
                        //.offset(x: -1, y: -1)
                )
            Text(word.sourceWord ?? "")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 40, trailing: 10))
            Text(translationsString)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: 50, leading: 10, bottom: 10, trailing: 10))
        }
    }
}

struct WordListItem_Previews: PreviewProvider {
    static var previews: some View {
        WordListItem(word: Word(sourceWord: "Hello", wordData: Set(), insertIntoManagedObjectContext: .none))
    }
}
