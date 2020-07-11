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
    @Environment(\.presentationMode) var presentation
    
    @FetchRequest(entity: Language.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "isCurrent == %@", NSNumber(value: true)))
    var langResults: FetchedResults<Language>
    
    var currentLang: Language {
        self.langResults.count != 0 ? self.langResults[0] : Language(id: 0, name: "", flag: "", code: "", isChosen: true, isCurrent: true, wordsList: Set(), insertIntoManagedObjectContext: managedObjectContext)
    }
    
    var currentLangFlag: String {
        currentLang.flag ?? ""
    }
    
    var currentLangName: String {
        currentLang.name ?? ""
    }
    
    @State var wordsListArray: [Word] = []
    
    var languageButton: some View {
        Button(action: {
            self.showingChosenLanguages.toggle()
        }, label: {
            Text(NSLocalizedString("Languages", comment: "Tap to choose a language"))
                .font(.system(size: 20))
        })
        .sheet(isPresented: $showingChosenLanguages, onDismiss: {
            self.updateWordsListArray()
        }, content: {
            LanguageChoiceView(currentLanguageId: Int(self.currentLang.id), langWasChosen: true, choiceMade: Binding<Bool>.constant(false), showingChosenLanguages: self.$showingChosenLanguages, isInitialView: false)
                .environment(\.managedObjectContext, self.managedObjectContext)
                .environmentObject(UserData())
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
        UINavigationBar.appearance().barTintColor = UIColor(named: "BGElement")
        UITableView.appearance().backgroundColor = UIColor(named: "BGElement")
        UITableViewCell.appearance().backgroundColor = UIColor(named: "BGElement")
        //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20) ?? UIFont()]
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var wordList: some View {
        List {
            HStack {
                Spacer()
                Text(currentLangFlag + " " + currentLangName + " " + currentLangFlag)
                    .font(Font.custom("Georgia-Bold", size: 25))
                Spacer()
            }
            .padding()
            .padding(.top)
            
            if(wordsListArray.isEmpty) {
                VStack(alignment: .center) {
                    ForEach(0..<3) { _ in
                        Spacer()
                    }
                    Text(NSLocalizedString("NoWordsYet", comment: "Tell user that there are no words yet and to press + to add a new word"))
                        .font(Font.custom("Georgia", size: 15))
                        .multilineTextAlignment(.center)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding()
            }
            
            ForEach(wordsListArray, id: \.sourceWord) { (wordInList: Word) in
                VStack {
                    Spacer()
                    ZStack {
                        WordListItem(word: wordInList)
                        NavigationLink(destination:
                            WordInfoView(originalWord: wordInList.sourceWord ?? "", wordDataSet: wordInList.wordData ?? Set())
                                .navigationBarTitle(Text(self.currentLangFlag + " " + self.currentLangName + " " + self.currentLangFlag)
                            .font(Font.custom("Georgia-Bold", size: 25))
                            , displayMode: .inline)
                        ) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .onDelete(perform: deleteWord)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BGElement")
                    .edgesIgnoringSafeArea(.all)
                    
                wordList
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(
                leading: languageButton,
                trailing: newWordButton
            )
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear() {
                self.updateWordsListArray()
            }
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
