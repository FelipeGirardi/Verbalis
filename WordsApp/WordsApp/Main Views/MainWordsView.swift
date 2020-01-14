//
//  MainWordsView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 13/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct MainWordsView: View {
    var body: some View {
        TabView{
            NavigationView {
                List {
                    Text("Hi")
                }
                    .navigationBarTitle("Palavras", displayMode: .inline)
                    .navigationBarItems(
                        leading: Button(action: {
                            // Actions
                        }, label: { Text("Línguas") }),

                        trailing: Button(action: {
                            // Actions
                        }, label: { Image(systemName: "plus") })
                    )
            }
            .tabItem {
               Image(systemName: "a")
               Text("Palavras")
            }
            
        }
    }
}

struct MainWordsView_Previews: PreviewProvider {
    static var previews: some View {
        MainWordsView()
    }
}
