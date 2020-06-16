//
//  ChangeLanguageView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 14/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct ChangeLanguageView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var showingChosenLanguages: Bool
    @State var langState: Int
    
    var body: some View {
        ChangeLanguageView2(showingChosenLanguages: self.$showingChosenLanguages, langState: State<Int>(initialValue: self.langState))
    }
}

struct ChangeLanguageView2: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var showingChosenLanguages: Bool
    @State var langState: Int
    
    @FetchRequest(entity: Language.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "isChosen == %@", NSNumber(value: true)))
    var langsChosenResults: FetchedResults<Language>
    
    var cancelButton: some View {
        Button(action: {
            self.showingChosenLanguages.toggle()
        }, label: {
            Text("Exit")
                .font(.system(size: 20))
        })
    }
    
    init(showingChosenLanguages: Binding<Bool>, langState: State<Int>) {
        UITableView.appearance().separatorStyle = .none
        self._showingChosenLanguages = showingChosenLanguages
        self._langState = langState
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Select a language:")
                    .font(Font.custom("Georgia", size: 25))
                    .fontWeight(.medium)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                
                Spacer()
                
                List {
                    ForEach(Array(self.langsChosenResults), id: \.self) { chosenLang in
                        VStack {
                            ChangeLanguageButton(langState: self.$langState, chosenLang: chosenLang)
                            Spacer()
                        }
                    }
                }
                
                Button(action: {
                    for lang in self.langsChosenResults {
                        lang.isCurrent = (lang.id == self.langState) ? true : false
                    }
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print("Could not save language info to CoreData")
                        print(error)
                    }
                    self.showingChosenLanguages.toggle()
                }, label: {
                    Text("Confirm")
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 20))
                        .foregroundColor(Color.white)
                })
                    .padding()
                    .background(Color(red: 64/255, green: 0/255, blue: 255/255))
                    .cornerRadius(40)
                    .shadow(color: Color.black, radius: 3, x: 0, y: 2)
                
                ForEach(0..<3) { _ in
                    Spacer()
                }
                        
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle(Text("Change language"), displayMode: .inline)
            .navigationBarItems(
                trailing: cancelButton
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

}

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
