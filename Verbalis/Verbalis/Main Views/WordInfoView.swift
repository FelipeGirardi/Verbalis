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
    var originalWord: String
    @State var wordDataSet: Set<WordData>
    
    var wordDataArray: [WordData] {
        Array(wordDataSet).sorted(by: {
            if $0.isMainWord?.boolValue ?? true && $1.isMainWord?.boolValue ?? true {
                return $0.targets?.count ?? 1 > $1.targets?.count ?? 1
            } else {
                return $0.isMainWord?.boolValue ?? true && !($1.isMainWord?.boolValue ?? true)
            }
        } )
    }
    
    init(originalWord: String, wordDataSet: Set<WordData>) {
        self.originalWord = originalWord
        self._wordDataSet = State(initialValue: wordDataSet)
    }
   
    func termTitle(term: WordData) -> some View {
        return VStack {
            Text(term.source?.lemma ?? "")
                .font(Font.custom("Georgia-Bold", size: 32))
            
            Spacer()
            
            HStack {
                Text(term.source?.partOfSpeech ?? "")
                    .font(Font.custom("Georgia", size: 20))
                
                Text(term.source?.inflection ?? "")
                    .font(Font.custom("Georgia", size: 20))
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    func prepareTranslations(translations: WordData) -> some View {
        let targets: [TargetData] = Array(translations.targets ?? Set()).sorted(by: { $0.rank ?? "" > $1.rank ?? "" } )
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
            
            // Translation
            Text("\(index). \(translationData.translationLemma ?? "")")
                    .font(Font.custom("Georgia", size: 24))
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
            // Examples
            if(!(translationData.examples?.isEmpty ?? true)) {
                Text(NSLocalizedString("Examples", comment: "Examples with given word"))
                    .font(Font.custom("Georgia", size: 20))
                    .fontWeight(.medium)
                
                Group {
                    ForEach(examples, id: \.exampleSource) { example in
                        HStack {
                            Text(example.exampleSource ?? "")
                                .font(Font.custom("Georgia", size: 16))
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Divider()
                                .padding(.leading)
                                .padding(.trailing)
                            
                            Text(example.exampleTarget ?? "")
                                .font(Font.custom("Georgia", size: 16))
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

            // Synonyms
            if(!(translationData.synonyms?.isEmpty ?? true)) {
                if(translationData.synonyms?[0] != "") {
                    Text(NSLocalizedString("Synonyms", comment: "Synonyms for given word"))
                        .font(Font.custom("Georgia", size: 20))
                        .fontWeight(.medium)
                        .padding(.bottom)
            
                    ForEach(translationData.synonyms ?? [], id: \.self) { synonym in
                        Text(synonym)
                            .font(Font.custom("Georgia", size: 16))
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
                Text(NSLocalizedString("OtherExamples", comment: "Other examples with given word"))
                    .font(Font.custom("Georgia", size: 20))
                    .fontWeight(.medium)
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
                .font(Font.custom("Georgia", size: 16))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.leading)
            
            Divider()
                .padding(.leading)
                .padding(.trailing)
            
            Text(example.target ?? "")
                .font(Font.custom("Georgia", size: 16))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing)
        }
    }
    
    var body: some View {
        ZStack {
            Color("BGElement")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical) {
                ForEach(wordDataArray.indices, id: \.self) { index in
                    Group {
                        if(index == 0) {
                            ForEach(0..<3) { _ in
                                Spacer()
                            }
                        }
                        
                        ForEach(0..<3) { _ in
                            Spacer()
                        }
                        
                        self.termTitle(term: self.wordDataArray[index])
                        
                        ForEach(0..<6) { _ in
                            Spacer()
                        }
                        
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
        }
    }
}

struct WordInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
