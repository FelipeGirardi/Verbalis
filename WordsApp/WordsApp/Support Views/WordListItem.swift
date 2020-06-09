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
        Array(word.wordData ?? Set()).sorted(by: { $0.isMainWord!.boolValue && !$1.isMainWord!.boolValue } )
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
                .fill(Color(red: 64/255, green: 0/255, blue: 255/255))
                .shadow(color: Color.black, radius: 3, x: 0, y: 2)
                //.padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
            Text(word.sourceWord ?? "")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 40, trailing: 10))
            Text(translationsString)
                .font(.system(size: 16))
                .fontWeight(.regular)
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
