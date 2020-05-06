//
//  WordInfoView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 05/03/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI
import Combine

struct WordInfoView: View {
    var selectedWord: Word
    
    var wordDataArray: [WordData] {
        Array(selectedWord.wordData ?? Set())
    }
    
    func termTitle(term: WordData) -> some View {
        return VStack {
            Text(term.source?.lemma ?? "")
                .font(Font.custom("Georgia-Bold", size: 30))
            
            Spacer()
            
            HStack {
                Text(term.source?.inflection ?? "")
                    .font(Font.custom("Georgia", size: 13))
                
                Text(term.source?.partOfSpeech ?? "")
                    .font(Font.custom("Georgia", size: 13))
            }
        }
    }
    
    func prepareTranslations(translations: WordData) -> some View {
        let targets: [TargetData] = Array(translations.targets ?? Set())
        return
            ForEach(targets.indices, id: \.self) { index in
                Group {
                    self.termTranslations(index: index+1, translationData: targets[index])
                }
            }
    }
    
    func termTranslations(index: Int, translationData: TargetData) -> some View {
        let examples: [Example] = Array(translationData.examples ?? Set())
        return VStack {
                Text("\(index). \(translationData.translationLemma ?? "")")
                    .font(Font.custom("Georgia", size: 20))
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
            if(!(translationData.examples?.isEmpty ?? true)) {
                    Text("Examples")
                        .font(Font.custom("Georgia", size: 16))
                    
                    Group {
                        ForEach(examples, id: \.exampleSource) { example in
                            HStack {
                                Text(example.exampleSource ?? "")
                                    .font(Font.custom("Georgia", size: 12))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                                Divider()
                                    .padding(.leading)
                                    .padding(.trailing)
                                
                                Text(example.exampleTarget ?? "")
                                    .font(Font.custom("Georgia", size: 12))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    
                    Spacer()
                    Spacer()
                }

            if(!(translationData.synonyms?.isEmpty ?? true)) {
                    if(translationData.synonyms?[0] != "") {
                        Text("Synonyms")
                            .font(Font.custom("Georgia", size: 16))
                            .padding(.bottom)
                
                        ForEach(translationData.synonyms ?? [], id: \.self) { synonym in
                            Text(synonym)
                                .font(Font.custom("Georgia", size: 12))
                                .padding(.top, 2)
                                .padding(.bottom, 2)
                        }
                    }
                }
            }
    }
    
    func prepareOtherExamples(wordData: WordData) -> some View {
        let otherExamplesArray: [OtherExample] = Array(wordData.otherExamples ?? Set())
        return Group {
            if(otherExamplesArray.count > 0) {
                Text("— Other Examples —")
                    .font(Font.custom("Georgia", size: 16))
                    .padding(.top)
                    .padding(.top)
                    .padding(.bottom, 8)
            }
            
            ForEach(otherExamplesArray, id: \.source) { example in
                self.otherExamples(example: example)
            }
        }
    }
    
    func otherExamples(example: OtherExample) -> some View {
        return HStack {
            Text(example.source ?? "")
                .font(Font.custom("Georgia", size: 12))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Divider()
                .padding(.leading)
                .padding(.trailing)
            
            Text(example.target ?? "")
                .font(Font.custom("Georgia", size: 12))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(wordDataArray.indices, id: \.self) { index in
                Group {
                    if(index != 0) {
                        ForEach(0..<3) { _ in
                            Spacer()
                        }
                    }
                    
                    self.termTitle(term: self.wordDataArray[index])
                    
                    Spacer()
                    
                    self.prepareTranslations(translations: self.wordDataArray[index])
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                    
                    self.prepareOtherExamples(wordData: self.wordDataArray[index])
                    
                    if(index != self.wordDataArray.count - 1) {
                        Divider()
                            .padding()
                            .padding(.top)
                    } else {
                        ForEach(0..<3) { _ in
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WordInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
