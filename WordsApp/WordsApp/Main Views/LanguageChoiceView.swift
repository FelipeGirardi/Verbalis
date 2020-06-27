//
//  LanguageChoiceView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 11/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct LanguageChoiceView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    @State var currentLanguageId: Int
    @State var langWasChosen: Bool
    @Binding var choiceMade: Bool
    @Binding var showingChosenLanguages: Bool
    var isInitialView: Bool
    
    @FetchRequest(entity: Language.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)],
                  predicate: NSPredicate(format: "isChosen == %@", NSNumber(value: true)))
    var langsChosenResults: FetchedResults<Language>
    
    var langsChosenResultsArray: [Language] {
        Array(self.langsChosenResults)
    }
    
    var animation: Animation {
        Animation.linear
            .speed(5)
            .delay(0.01)
    }
    
    var cancelButton: some View {
        Button(action: {
            self.showingChosenLanguages.toggle()
        }, label: {
            Text("Exit")
                .font(.system(size: 20))
        })
    }
    
    func calculateRowColumn(row: Int, column: Int) -> Int {
        return row * 2 + column
    }
    
    fileprivate func mainLanguageButton(row: Int, column: Int) -> some View {
        let isCurrentlyPicked: Bool
        if(isInitialView) {
            isCurrentlyPicked = self.userData.languages[self.calculateRowColumn(row: row, column: column)].id == self.currentLanguageId
        } else {
            isCurrentlyPicked = self.langsChosenResultsArray[self.calculateRowColumn(row: row, column: column)].id == self.currentLanguageId
        }
        
        return Button(action: {
            withAnimation(.easeInOut(duration: 0.1)) {
                if(!self.langWasChosen) {
                    self.langWasChosen = true
                } else {
                    if(self.isInitialView) {
                        self.userData.languages[self.currentLanguageId].isCurrent = false
                    } else {
                        self.langsChosenResultsArray[self.currentLanguageId].isCurrent = false
                    }
                }
                
                self.currentLanguageId = self.calculateRowColumn(row: row, column: column)
                if(self.isInitialView) {
                    self.userData.languages[self.currentLanguageId].isCurrent = true
                } else {
                    self.langsChosenResultsArray[self.currentLanguageId].isCurrent = true
                }
            }
        }) {
            self.isInitialView ?
                
                LanguageSelectorView(language: self.userData.languages[self.calculateRowColumn(row: row, column: column)].name ?? "", flag: self.userData.languages[self.calculateRowColumn(row: row, column: column)].flag ?? "", isButtonPressed: isCurrentlyPicked)
                    //                                        .overlay(
                    //                                            RoundedRectangle(cornerRadius: 40)
                    //                                                .stroke(self.userData.languages[self.calculateRowColumn(row: row, column: column)].id == self.currentLanguageId ? Color(red: 255/255, green: 215/255, blue: 0/255) : Color(red: 64/255, green: 0/255, blue: 255/255), lineWidth: 10)
                    //                                        )
                    .padding(EdgeInsets(top: 10, leading: 6, bottom: 10, trailing: 6))
                
                :
                
                LanguageSelectorView(language: self.langsChosenResultsArray[self.calculateRowColumn(row: row, column: column)].name ?? "", flag: self.langsChosenResultsArray[self.calculateRowColumn(row: row, column: column)].flag ?? "", isButtonPressed: isCurrentlyPicked)
                    //                                    .overlay(
                    //                                        RoundedRectangle(cornerRadius: 40)
                    //                                            .stroke(self.langsChosenResultsArray[self.calculateRowColumn(row: row, column: column)].id == self.currentLanguageId ? Color(red: 255/255, green: 215/255, blue: 0/255) : Color(red: 64/255, green: 0/255, blue: 255/255), lineWidth: 10)
                    //                                    )
                    .padding(EdgeInsets(top: 10, leading: 6, bottom: 10, trailing: 6))
        }
        .foregroundColor(Color("BGElement"))
        .scaleEffect(isCurrentlyPicked ? 0.95 : 1.0)
        .animation(.spring())
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BGElement")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text(self.isInitialView ? "Hello!\n\nWhat language are you learning?" : "What language are you learning?")
                        .font(Font.custom("Georgia-Bold", size: 25))
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer()
                    
                    ForEach(0 ..< 3) { row in
                        HStack {
                            ForEach(0 ..< 2) { column in
                                self.mainLanguageButton(row: row, column: column)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        // Mark all languages as chosen to prevent duplication later
                        if(self.isInitialView) {
                            for lang in self.userData.languages {
                                lang.isChosen = true
                            }
                            self.choiceMade.toggle()
                            UserDefaults.standard.set(true, forKey: "choiceMade")
                        } else {
                            for lang in self.langsChosenResults {
                                lang.isCurrent = (lang.id == self.currentLanguageId) ? true : false
                            }
                            self.showingChosenLanguages.toggle()
                        }

                        UserDefaults.standard.set(self.currentLanguageId, forKey: "currentLanguageId")
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print("Could not save language info to CoreData")
                            print(error)
                        }
                        
                    }, label: {
                        Text("Start")
                            .fontWeight(.semibold)
                            .font(Font.custom("Georgia", size: 25))
                            .foregroundColor(Color.white)
                            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                    })
                    .disabled(!self.langWasChosen)
                    .background(Color(red: 64/255, green: 0/255, blue: 255/255))
                    .cornerRadius(40)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .opacity(self.langWasChosen ? 1.0 : 0.25)
                    .shadow(color: Color.black, radius: 3, x: 0, y: 2)
                    .animation(self.animation)
                    
                    Spacer()
                }
                .navigationBarTitle(Text("Change language"), displayMode: .inline)
                .navigationBarItems(
                    trailing: cancelButton
                )
                .navigationBarHidden(self.isInitialView)
                .onAppear() {
                    if(self.isInitialView) {
                        for row in (0 ..< 3) {
                            for column in (0 ..< 2) {
                                let position = self.calculateRowColumn(row: row, column: column)
                                self.userData.languages[position].id = Int16(position)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LanguageChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
