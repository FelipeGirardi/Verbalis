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
        Array(word.wordData ?? Set()).sorted(by: { $0.source?.lemma ?? "" < $1.source?.lemma ?? "" } )
    }
    
    var firstWordTargets: [TargetData] {
        Array(wordDataArray[0].targets ?? Set()).sorted(by: { $0.rank ?? "" < $1.rank ?? "" } )
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 50/255, green: 50/255, blue: 255/255))
                //.stroke(Color(red: 50/255, green: 50/255, blue: 255/255), lineWidth: 3)
            Text(word.sourceWord ?? "")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 40, trailing: 10))
            Text(firstWordTargets[0].translationLemma ?? "")
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
