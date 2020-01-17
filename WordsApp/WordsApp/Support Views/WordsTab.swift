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
    @EnvironmentObject var userData: UserData
    
    var currentLanguage: Language {
        self.userData.languages[self.userData.currentLanguageId]
    }
    
    var langName: String {
        self.currentLanguage.name
    }
    
    var languageButton: some View {
        Button(action: {
            self.showingChosenLanguages.toggle()
        }, label: {
            Text("Línguas")
                .font(.system(size: 20))
        })
        .sheet(isPresented: $showingChosenLanguages, onDismiss: {
            
        }, content: {
            ChangeLanguageView(showingChosenLanguages: self.$showingChosenLanguages)
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
            MainNewWordView()
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
                ForEach(currentLanguage.wordsList, id: \.self) { word in
                    Text(word.wordString)
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
