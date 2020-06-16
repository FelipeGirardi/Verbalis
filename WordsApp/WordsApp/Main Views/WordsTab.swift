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
    
    @State var wordsListArray: [Word] = []
    
    var languageButton: some View {
        Button(action: {
            self.showingChosenLanguages.toggle()
        }, label: {
            Text("Languages")
                .font(.system(size: 20))
        })
        .sheet(isPresented: $showingChosenLanguages, onDismiss: {
            self.updateWordsListArray()
        }, content: {
            ChangeLanguageView(showingChosenLanguages: self.$showingChosenLanguages, langState: Int(self.currentLang.id))
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
            self.updateWordsListArray()
        }, content: {
            AddWordView(showingAddWord: self.$showingAddWord, currentLangCode: self.currentLang.code ?? "de")
                .environmentObject(self.userData)
            }
        )
    }
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 30) ?? UIFont()]
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(wordsListArray, id: \.sourceWord) { (wordInList: Word) in
                    VStack {
                        Spacer()
                        ZStack {
                            WordListItem(word: wordInList)
                            NavigationLink(destination:
                                WordInfoView(originalWord: wordInList.sourceWord ?? "", wordDataSet: wordInList.wordData ?? Set())
                            ) {
                                EmptyView()
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .onDelete(perform: deleteWord)
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
        .onAppear() {
            self.updateWordsListArray()
        }
    }
    
    func updateWordsListArray() {
        self.wordsListArray = Array(self.currentLang.wordsList ?? Set()).sorted { $0.sourceWord?.lowercased() ?? "" < $1.sourceWord?.lowercased() ?? "" }
    }
    
    func deleteWord(at offsets: IndexSet) {
        withAnimation(.easeInOut(duration: 0.2)) {
            for index in offsets {
                let word = wordsListArray[index]
                managedObjectContext.delete(word)
            }
            do {
                try managedObjectContext.save()
                self.updateWordsListArray()
            } catch {
                print("Could not save to CoreData")
                print(error)
            }
        }
    }
}

struct WordsTab_Previews: PreviewProvider {
    static var previews: some View {
        return WordsTab()
            .environmentObject(UserData())
    }
}
