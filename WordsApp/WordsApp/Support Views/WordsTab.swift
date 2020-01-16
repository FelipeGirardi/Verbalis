//
//  WordsTab.swift
//  WordsApp
//
//  Created by Felipe Girardi on 13/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct WordsTab: View {
    @State private var showingChosenLanguages: Bool = false
    @State private var showingAddWord: Bool = false
    @EnvironmentObject var userData: UserData
    
    var currentLanguage: LanguageChoice {
        self.userData.chosenLanguages.first(where: { $0.id == self.userData.currentLanguageId})!
    }
    var langName: String {
        self.currentLanguage.name
    }
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 30) ?? UIFont()]
            //.foregroundColor: UIColor(red: 50/255, green: 50/255, blue: 255/255, alpha: 255/255)]
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(currentLanguage.wordsList, id: \.self) { word in
                    Text(word.wordString)
                }
            }
            //.padding(.top, 20)
                .navigationBarTitle(Text(currentLanguage.flag + " " + currentLanguage.name)
                    .font(Font.custom("Georgia-Bold", size: 25))
                    , displayMode: .large)
                .navigationBarItems(
                    leading: Button(action: {
                        self.showingChosenLanguages.toggle()
                    }, label: { Text("Línguas")
                        .font(.system(size: 20))
                        //.foregroundColor(Color(red: 50/255, green: 50/255, blue: 255/255))
                    }),

                    trailing: Button(action: {
                        self.showingAddWord.toggle()
                    }, label: { Image(systemName: "plus")
                        .font(.system(size: 20))
                        //.foregroundColor(Color(red: 50/255, green: 50/255, blue: 255/255))
                    })
                )
                .sheet(isPresented: $showingChosenLanguages, onDismiss: {
                    
                }, content: {
                    ChangeLanguageView(showingChosenLanguages: self.$showingChosenLanguages)
                        .environmentObject(self.userData)
                    }
                )
            
                .sheet(isPresented: $showingAddWord, onDismiss: {
                    
                }, content: {
                    AddWordView(showingAddWord: self.$showingAddWord)
                        .environmentObject(self.userData)
                    }
                )
            
        }
    }
}

struct WordsTab_Previews: PreviewProvider {
    static var previews: some View {
        WordsTab()
    }
}
