//
//  LanguageChoiceView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 11/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct LanguageChoiceView: View {
    
    @EnvironmentObject var userData: UserData
    @State private var nSelected = 0
    @Binding var choiceMade: Bool
    
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
                    //.fontWeight(.bold)
                    .font(Font.custom("Georgia-Bold", size: 25))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                Spacer()
                
                    ForEach(0 ..< 3) { row in
                        HStack {
                            ForEach(0 ..< 2) { column in
                                Button(action: {
                                    withAnimation {
                                        let position = self.calculateRowColumn(row: row, column: column)
                                        self.userData.languages[position].isChosen.toggle()
                                        if(self.userData.languages[position].isChosen) {
                                            self.nSelected += 1
                                            if(self.nSelected == 1) {
                                                self.userData.currentLanguageId = self.userData.languages[position].id
                                                self.userData.currentLanguageCode = self.userData.languages[position].code
                                            }
                                        }
                                        else {
                                            self.nSelected -= 1
                                        }
                                    }
                                }) {
                                    LanguageSelectorView(language: self.userData.languages[self.calculateRowColumn(row: row, column: column)].name, flag: self.userData.languages[self.calculateRowColumn(row: row, column: column)].flag)
                                        //.background(self.userData.languages[self.calculateRowColumn(row: row, column: column)].isChosen ? Color(.cyan) : Color(.clear))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(self.userData.languages[self.calculateRowColumn(row: row, column: column)].isChosen ? Color(red: 255/255, green: 215/255, blue: 0/255) : Color(red: 50/255, green: 50/255, blue: 255/255), lineWidth: 10)
                                        )
                                        //.cornerRadius(40)
                                        .padding(EdgeInsets(top: 10, leading: 6, bottom: 10, trailing: 6))
                                }
                                .animation(self.animation)
                            }
                        }
                    }
                
                Spacer()
                
                Button(action: {
                    self.choiceMade = true
                }, label: {
                    Text("Start")
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 20))
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                })
                .background(Color(red: 50/255, green: 50/255, blue: 255/255))
                .cornerRadius(40)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 40)
//                            .stroke(Color(.black), lineWidth: 3)
//                    )
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .opacity(nSelected == 0 ? 0.25 : 1.0)
                .animation(self.animation)
                
                Spacer()
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
