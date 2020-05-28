//
//  WordsTab.swift
//  WordsApp
//
//  Created by Felipe Girardi on 13/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct WordsTab: View {
    @State private var showingChosenLanguages = false
    @State private var showingAddWord = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    
    @FetchRequest(entity: Language.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "isCurrent == %@", NSNumber(value: true)))
    var langResults: FetchedResults<Language>
    
    var currentLang: Language {
        self.langResults.count != 0 ? self.langResults[0] : Language(id: 0, name: "", flag: "", code: "", isChosen: true, isCurrent: true, wordsList: Set(), insertIntoManagedObjectContext: managedObjectContext)
    }
    
    var wordsListArray: [Word] {
        Array(currentLang.wordsList ?? Set()).sorted { $0.sourceWord?.lowercased() ?? "" < $1.sourceWord?.lowercased() ?? "" }
    }
    
    var languageButton: some View {
        Button(action: {
            self.showingChosenLanguages.toggle()
        }, label: {
            Text("Languages")
                .font(.system(size: 20))
        })
        .sheet(isPresented: $showingChosenLanguages, onDismiss: {
            
        }, content: {
            ChangeLanguageView(showingChosenLanguages: self.$showingChosenLanguages, langState: State<Int>(initialValue: Int(self.currentLang.id)))
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
        )
    }
    
    var newWordButton: some View {
        Button(action: {
            self.showingAddWord.toggle()
        }, label: {
            Image(systemName: "plus")
                .font(.system(size: 20))
        })
        .sheet(isPresented: $showingAddWord, onDismiss: {
            
        }, content: {
            AddWordView(showingAddWord: self.$showingAddWord, currentLangCode: self.currentLang.code ?? "de")
                .environmentObject(self.userData)
            }
        )
    }
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 30) ?? UIFont()]
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(wordsListArray, id: \.sourceWord) { wordInList in
                    NavigationLink(destination:
                    WordInfoView(selectedWord: wordInList)
                        .offset(y: -30)) {
                            WordListItem(word: wordInList)
                    }
                }
            }
                .navigationBarTitle(Text((currentLang.flag ?? "") + " " + (currentLang.name ?? ""))
                    .font(Font.custom("Georgia-Bold", size: 25))
                    , displayMode: .large)
                .navigationBarItems(
                    leading: languageButton,
                    trailing: newWordButton
                )
        }
        .navigationViewStyle(DefaultNavigationViewStyle())
    }
}

struct WordsTab_Previews: PreviewProvider {
    static var previews: some View {
        return WordsTab()
            .environmentObject(UserData())
    }
}
