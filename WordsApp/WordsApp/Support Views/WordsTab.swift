//
//  WordsTab.swift
//  WordsApp
//
//  Created by Felipe Girardi on 13/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct WordsTab: View {
    @State var showingChosenLanguages = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 30) ?? UIFont()]
            //.foregroundColor: UIColor(red: 50/255, green: 50/255, blue: 255/255, alpha: 255/255)]
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            List {
                Text("Hi 1")
                Text("Hi 2")
                Text("Hi 3")
            }
            //.padding(.top, 20)
            .navigationBarTitle("Palavras", displayMode: .large)
                .navigationBarItems(
                    leading: Button(action: {
                        self.showingChosenLanguages.toggle()
                    }, label: { Text("Línguas")
                        .font(.system(size: 20))
                        //.foregroundColor(Color(red: 50/255, green: 50/255, blue: 255/255))
                    }),

                    trailing: Button(action: {
                        // Actions
                    }, label: { Image(systemName: "plus")
                        .font(.system(size: 20))
                        //.foregroundColor(Color(red: 50/255, green: 50/255, blue: 255/255))
                    })
                )
            .sheet(isPresented: $showingChosenLanguages) {
                EmptyView()
            }
        }
    }
}

struct WordsTab_Previews: PreviewProvider {
    static var previews: some View {
        WordsTab()
    }
}
