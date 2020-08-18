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
        Array(wordDataArray.first?.targets ?? Set()).sorted { (target1, target2) -> Bool in
            return Int(target1.rank ?? "") ?? 0 > Int(target2.rank ?? "") ?? 0
        }
    }
    
    var translationsString: String {
        var tempString: String = ""
        let numberOfPreviewTranslations: Int = firstWordTargets.count < 3 ? firstWordTargets.count : 3
        for target in firstWordTargets[0 ..< numberOfPreviewTranslations] {
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
                        .stroke(Color("Main"), lineWidth: 1)
                        .blur(radius: 2)
                )
                .accessibility(label: Text(word.sourceWord ?? ""))
                .accessibility(addTraits: .isButton)
                .accessibility(hint: Text("PressWordListItem"))
            
            HStack(spacing: 5) {
                VStack(spacing: 10) {
                    Text(word.sourceWord ?? "")
                        .font(Font.custom("Georgia-Bold", size: 28))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    Text(translationsString)
                        .font(Font.custom("Georgia", size: 16))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Image("forward50")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32.0, height: 32.0)
                    .padding(.trailing, 10)
                    .accessibility(hidden: true)
            }
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 20, trailing: 5))
        }
    }
}

struct WordListItem_Previews: PreviewProvider {
    static var previews: some View {
        WordListItem(word: Word(sourceWord: "Hello", wordData: Set(), insertIntoManagedObjectContext: .none))
    }
}
