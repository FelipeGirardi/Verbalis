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
        return HStack {
            Text(term.source?.lemma ?? "")
                .font(Font.custom("Georgia-Bold", size: 20))
            
            Text(term.source?.inflection ?? "")
                .font(Font.custom("Georgia", size: 12))
            
            Text(term.source?.partOfSpeech ?? "")
                .font(Font.custom("Georgia", size: 12))
        }
    }
    
    func termTranslations(translationData: Target) -> some View {
        return
            VStack {
                Group {
                    Spacer()
                    
                    Text(translationData.translationLemma ?? "")
                        .font(Font.custom("Georgia", size: 16))
                    
                    Spacer()
                    
                    Text(translationData.examples?.count ?? 0 > 0 ? "Examples: " : "")
                        .font(Font.custom("Georgia-Bold", size: 12))
                }
                
                    ForEach(translationData.examples ?? [], id: \.source) { example in
                        Group {
                            HStack {
                                Spacer()
                                Text(example.source ?? "")
                                    .font(Font.custom("Georgia", size: 12))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                Text(example.target ?? "")
                                    .font(Font.custom("Georgia", size: 12))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                    Spacer()
                
                    Text("Synonyms: ")
                        .font(Font.custom("Georgia-Bold", size: 12))
                    
                    ForEach(translationData.synonyms ?? [], id: \.self) { synonym in
                        Text(synonym)
                            .font(Font.custom("Georgia", size: 12))
                    }
                    Spacer()
            }
    }
    
    var body: some View {
        ScrollView {
            ForEach(selectedWord.wordData, id: \.source?.lemma) { term in
                Group {
                    self.termTitle(term: term)
                    
                    Spacer()
                    
                    ForEach(term.targets ?? [], id: \.translationLemma) { translation in
                        self.termTranslations(translationData: translation)
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
}

struct WordInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WordInfoView(selectedWord: Word(sourceWord: "sorgen", wordData: [WordsApp.WordData(otherExamples: Optional([WordsApp.OtherExample(context: Optional(""), source: Optional("für Schlagzeile sorgen"), target: Optional("to grab headlines")), WordsApp.OtherExample(context: Optional(""), source: Optional("für die Fluchtwege sorgen"), target: Optional("to look for the escape routes"))]), source: Optional(WordsApp.Source(inflection: Optional("(sorgt/sorgte/gesorgt)"), info: Optional(""), lemma: Optional("sorgen"), phonetic: Optional(""), partOfSpeech: Optional("verb"), term: Optional("sorgen"))), targets: Optional([WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([WordsApp.Example(source: Optional("für Transparenz sorgen"), target: Optional("to ensure transparency"))]), info: Optional(""), synonyms: Optional(["sicherstellen", "gewährleisten", "sichern", "garantieren", "erreichen"]), translationLemma: Optional("to ensure"), rank: Optional("49")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["bieten", "vorsehen", "geben", "bereitstellen", "liefern", "leisten", "erbringen", "schaffen", "übermitteln"]), translationLemma: Optional("to provide"), rank: Optional("22")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["bringen", "führen", "kommen", "stellen", "einbringen", "holen", "mitbringen", "setzen"]), translationLemma: Optional("to bring"), rank: Optional("5")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["sicherstellen", "sichergehen", "achten", "sich vergewissern", "vergewissern"]), translationLemma: Optional("to make sure"), rank: Optional("3")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["liefern", "abgeben", "nehmen", "bringen", "leisten", "einhalten", "erbringen", "ab~geben"]), translationLemma: Optional("to deliver"), rank: Optional("1")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["sichern", "sicherstellen", "gewährleisten", "erzielen", "durchsetzen", "absichern"]), translationLemma: Optional("to secure"), rank: Optional("1")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["sich kümmern", "kümmern", "sich sorgen", "sich interessieren", "interessieren", "sich scheren", "betreuen", "pflegen"]), translationLemma: Optional("to care"), rank: Optional("1")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["besorgen", "beunruhigen", "sich sorgen", "befürchten", "fürchten", "Sorgen sich machen", "Besorgnis erregen", "Sorgen machen"]), translationLemma: Optional("to worry"), rank: Optional("1")), WordsApp.Target(context: Optional(""), entryID: Optional(49488), examples: Optional([]), info: Optional(""), synonyms: Optional(["erzeugen", "schaffen", "generieren", "erwirtschaften", "hervorrufen", "hervorbringen", "entstehen", "verursachen", "produzieren"]), translationLemma: Optional("to generate"), rank: Optional("1"))])), WordsApp.WordData(otherExamples: nil, source: Optional(WordsApp.Source(inflection: Optional("(sorgt/sorgte/gesorgt)"), info: Optional(""), lemma: Optional("sich sorgen"), phonetic: Optional(""), partOfSpeech: Optional("verb"), term: Optional("sorgen"))), targets: Optional([WordsApp.Target(context: Optional(""), entryID: Optional(49489), examples: Optional([WordsApp.Example(source: Optional("um den nationalen Niedergang sich sorgen"), target: Optional("to worry about national decline"))]), info: Optional(""), synonyms: Optional(["besorgen", "beunruhigen", "befürchten", "fürchten", "Sorgen sich machen", "Besorgnis erregen", "sorgen", "Sorgen machen"]), translationLemma: Optional("to worry"), rank: Optional("7")), WordsApp.Target(context: Optional(""), entryID: Optional(49489), examples: Optional([WordsApp.Example(source: Optional("um das Falsche sich sorgen"), target: Optional("to care about the wrong things"))]), info: Optional(""), synonyms: Optional(["sich kümmern", "kümmern", "sich interessieren", "sorgen", "interessieren", "sich scheren", "betreuen", "pflegen"]), translationLemma: Optional("to care"), rank: Optional("2"))]))]))
    }
}
