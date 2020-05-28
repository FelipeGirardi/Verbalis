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
    
    var body: some View {
        HStack {
            Text(word.sourceWord ?? "")
                .font(.system(size: 20))
                .fontWeight(.regular)
        }
    }
}

struct WordListItem_Previews: PreviewProvider {
    static var previews: some View {
        WordListItem(word: Word(sourceWord: "", wordData: Set(), insertIntoManagedObjectContext: .none))
    }
}
