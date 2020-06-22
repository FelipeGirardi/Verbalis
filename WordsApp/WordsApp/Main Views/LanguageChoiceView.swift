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
    @Binding var choiceMade: Bool
    @State var currentLanguageId: Int = 0
    @State var langWasChosen: Bool = false
    
    var animation: Animation {
        Animation.linear
            .speed(5)
            .delay(0.01)
    }
    
    func calculateRowColumn(row: Int, column: Int) -> Int {
        return row * 2 + column
    }
    
    var body: some View {
            VStack {
                Spacer()
                
                Text("Which language(s) are you learning?")
                    .font(Font.custom("Georgia-Bold", size: 25))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                Spacer()
                
                ForEach(0 ..< 3) { row in
                    HStack {
                        ForEach(0 ..< 2) { column in
                            Button(action: {
                                withAnimation {
                                    if(!self.langWasChosen) {
                                        self.langWasChosen = true
                                    } else {
                                        self.userData.languages[self.currentLanguageId].isCurrent = false
                                    }

                                    self.currentLanguageId = self.calculateRowColumn(row: row, column: column)
                                    self.userData.languages[self.currentLanguageId].isCurrent = true
                                }
                            }) {
                                LanguageSelectorView(language: self.userData.languages[self.calculateRowColumn(row: row, column: column)].name ?? "", flag: self.userData.languages[self.calculateRowColumn(row: row, column: column)].flag ?? "")
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(self.userData.languages[self.calculateRowColumn(row: row, column: column)].id == self.currentLanguageId ? Color(red: 255/255, green: 215/255, blue: 0/255) : Color(red: 64/255, green: 0/255, blue: 255/255), lineWidth: 10)
                                    )
                                    .padding(EdgeInsets(top: 10, leading: 6, bottom: 10, trailing: 6))
                            }
                            .animation(self.animation)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // - MARK: TEMPORARY
                    //self.userData.languages[self.currentLanguageId].isChosen.toggle()
                    
                    for lang in self.userData.languages {
                        lang.isChosen = true
                    }
                    
                    self.choiceMade = true
                    UserDefaults.standard.set(true, forKey: "choiceMade")
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
        .onAppear() {
            for row in (0 ..< 3) {
                    for column in (0 ..< 2) {
                        let position = self.calculateRowColumn(row: row, column: column)
                        self.userData.languages[position].id = Int16(position)
                    }
                }
        }
    }
}

struct LanguageChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return LanguageChoiceView(choiceMade: .constant(false))
            .environmentObject(userData)
    }
}
