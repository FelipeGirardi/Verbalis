//
//  WordsTab.swift
//  WordsApp
//
//  Created by Felipe Girardi on 13/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI
import Combine

struct WordsTab: View {
    @State private var showingChosenLanguages = false
    @State private var showingAddWord = false
    @EnvironmentObject var userData: UserData
//    @ObservedObject var addWordViewModel: AddWordViewModel = AddWordViewModel()
    
    var currentLanguage: Language {
        self.userData.languages[self.userData.currentLanguageId]
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
            ChangeLanguageView(showingChosenLanguages: self.$showingChosenLanguages, langState: State<Int>(initialValue: self.userData.currentLanguageId), codeState: State<String>(initialValue: self.userData.currentLanguageCode))
                .environmentObject(self.userData)
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
            AddWordView(showingAddWord: self.$showingAddWord)
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
                ForEach(currentLanguage.wordsList, id: \.sourceWord) { wordInList in
//                    Text("► ")
//                        .font(.system(size: 30))
//                        .fontWeight(.bold)
//                        .foregroundColor(Color(red: 50/255, green: 50/255, blue: 255/255))
                    NavigationLink(destination: WordInfoView(selectedWord: Word(sourceWord: wordInList.sourceWord, wordData: wordInList.wordData))) {
                        Text(wordInList.sourceWord)
                            .font(.system(size: 20))
                            .fontWeight(.regular)
                    }
                }
            }
                .navigationBarTitle(Text(currentLanguage.flag + " " + currentLanguage.name)
                    .font(Font.custom("Georgia-Bold", size: 25))
                    , displayMode: .large)
                .navigationBarItems(
                    leading: languageButton,
                    trailing: newWordButton
                )
        }
    }
}

struct WordsTab_Previews: PreviewProvider {
    static var previews: some View {
        WordsTab()
    }
}
