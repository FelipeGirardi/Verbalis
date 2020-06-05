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
    //@EnvironmentObject var userData: UserData
    @Binding var showingChosenLanguages: Bool
    @State var langState: Int
    
    @FetchRequest(entity: Language.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "isChosen == %@", NSNumber(value: true)))
    var langResults: FetchedResults<Language>
    
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
                    ForEach(self.langResults, id: \.self) { chosenLang in
                        Button(action: {
                            self.langState = Int(chosenLang.id)
                        }) {
                            chosenLang.id == self.langState ? ChangeLanguageButton(langName: chosenLang.name ?? "", langFlag: chosenLang.flag ?? "", bgColor: Color(red: 64/255, green: 0/255, blue: 255/255), borderColor: Color(red: 64/255, green: 0/255, blue: 255/255), borderWidth: 3, textColor: Color.white) : ChangeLanguageButton(langName: chosenLang.name ?? "", langFlag: chosenLang.flag ?? "", bgColor: Color(.clear), borderColor: Color(.black), borderWidth: 1, textColor: Color.black)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    for lang in self.langResults {
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
                    //.padding(.top, -120)
                
                Spacer()
                        
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
