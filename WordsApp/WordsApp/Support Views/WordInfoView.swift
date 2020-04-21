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
    
    func prepareTranslations(translations: [Target]) -> some View {
        return
            ForEach(translations.indices, id: \.self) { index in
                Group {
                    self.termTranslations(index: index+1, translationData: translations[index])
                }
            }
    }
    
    func termTranslations(index: Int, translationData: Target) -> some View {
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
                        ForEach(translationData.examples ?? [], id: \.exampleSource) { example in
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
            ForEach(selectedWord.wordData, id: \.source?.lemma) { term in
                Group {
                    Spacer()
                    
                    self.termTitle(term: term)
                    
                    Spacer()
                    
                    self.prepareTranslations(translations: term.targets ?? [])
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                    
                    Group {
                        if(term.otherExamples?.count ?? 0 > 0) {
                            Text("— Other Examples —")
                                .font(Font.custom("Georgia", size: 16))
                                .padding(.top)
                                .padding(.top)
                                .padding(.bottom, 8)
                        }
                        
                        ForEach(term.otherExamples ?? [], id: \.source) { example in
                            self.otherExamples(example: example)
                        }
                    }
                    
                    if(term != self.selectedWord.wordData.last) {
                        Divider()
                            .padding()
                            .padding(.top)
                    } else {
                        Spacer()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WordInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WordInfoView(selectedWord: Word(sourceWord: "sorgen", wordData: [WordsApp.WordData(otherExamples: Optional([WordsApp.OtherExample(context: Optional(""), source: Optional("für Schlagzeile sorgen"), target: Optional("to grab headlines")), WordsApp.OtherExample(context: Optional(""), source: Optional("für die Fluchtwege sorgen"), target: Optional("to look for the escape routes"))]), source: Optional(WordsApp.Source(inflection: Optional("(sorgt/sorgte/gesorgt)"), info: Optional(""), lemma: Optional("sorgen"), phonetic: Optional(""), partOfSpeech: Optional("verb"), term: Optional("sorgen"))), targets: Optional([WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([WordsApp.Example(exampleSource: Optional("für Transparenz sorgen"), exampleTarget: Optional("to ensure transparency"))]), info: Optional(""), synonyms: Optional(["sicherstellen", "gewährleisten", "sichern", "garantieren", "erreichen"]), translationLemma: Optional("to ensure"), rank: Optional("49")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["bieten", "vorsehen", "geben", "bereitstellen", "liefern", "leisten", "erbringen", "schaffen", "übermitteln"]), translationLemma: Optional("to provide"), rank: Optional("22")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["bringen", "führen", "kommen", "stellen", "einbringen", "holen", "mitbringen", "setzen"]), translationLemma: Optional("to bring"), rank: Optional("5")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["sicherstellen", "sichergehen", "achten", "sich vergewissern", "vergewissern"]), translationLemma: Optional("to make sure"), rank: Optional("3")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["liefern", "abgeben", "nehmen", "bringen", "leisten", "einhalten", "erbringen", "ab~geben"]), translationLemma: Optional("to deliver"), rank: Optional("1")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["sichern", "sicherstellen", "gewährleisten", "erzielen", "durchsetzen", "absichern"]), translationLemma: Optional("to secure"), rank: Optional("1")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["sich kümmern", "kümmern", "sich sorgen", "sich interessieren", "interessieren", "sich scheren", "betreuen", "pflegen"]), translationLemma: Optional("to care"), rank: Optional("1")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["besorgen", "beunruhigen", "sich sorgen", "befürchten", "fürchten", "Sorgen sich machen", "Besorgnis erregen", "Sorgen machen"]), translationLemma: Optional("to worry"), rank: Optional("1")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["erzeugen", "schaffen", "generieren", "erwirtschaften", "hervorrufen", "hervorbringen", "entstehen", "verursachen", "produzieren"]), translationLemma: Optional("to generate"), rank: Optional("1"))])), WordsApp.WordData(otherExamples: nil, source: Optional(WordsApp.Source(inflection: Optional("(sorgt/sorgte/gesorgt)"), info: Optional(""), lemma: Optional("sich sorgen"), phonetic: Optional(""), partOfSpeech: Optional("verb"), term: Optional("sorgen"))), targets: Optional([WordsApp.Target(context: Optional(""), entryID: Optional(49489), examples: Optional([WordsApp.Example(exampleSource: Optional("um den nationalen Niedergang sich sorgen"), exampleTarget: Optional("to worry about national decline"))]), info: Optional(""), synonyms: Optional(["besorgen", "beunruhigen", "befürchten", "fürchten", "Sorgen sich machen", "Besorgnis erregen", "sorgen", "Sorgen machen"]), translationLemma: Optional("to worry"), rank: Optional("7")), WordsApp.Target(context: Optional(""), entryID: Optional(49489), examples: Optional([WordsApp.Example(exampleSource: Optional("um das Falsche sich sorgen"), exampleTarget: Optional("to care about the wrong things"))]), info: Optional(""), synonyms: Optional(["sich kümmern", "kümmern", "sich interessieren", "sorgen", "interessieren", "sich scheren", "betreuen", "pflegen"]), translationLemma: Optional("to care"), rank: Optional("2"))]))]))
    }
}
