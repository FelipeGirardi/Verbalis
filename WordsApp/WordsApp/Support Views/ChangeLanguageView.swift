//
//  ChangeLanguageView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 14/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct ChangeLanguageView: View {
    @EnvironmentObject var userData: UserData
    @Binding var showingChosenLanguages: Bool
    
    var chosenLanguages: [Language] {
        self.userData.languages.filter { $0.isChosen }
    }
    
    init(showingChosenLanguages: Binding<Bool>) {
        UITableView.appearance().separatorStyle = .none
        self._showingChosenLanguages = showingChosenLanguages
    }
    
    var body: some View {
        VStack {
            Text("Selecione uma língua:")
                .font(Font.custom("Georgia", size: 25))
                .fontWeight(.medium)
                .padding(.top, 50)
                .padding(.bottom, 100)
            
            List {
                ForEach(self.chosenLanguages, id: \.self) { chosenLang in
                    Button(action: {
                        self.userData.currentLanguageId = chosenLang.id
                        print(self.userData.currentLanguageId)
                    }) {
                        chosenLang.id == self.userData.currentLanguageId ? ChangeLanguageButton(langName: chosenLang.name, langFlag: chosenLang.flag, bgColor: Color(red: 255/255, green: 215/255, blue: 0/255), borderColor: Color(red: 50/255, green: 50/255, blue: 255/255), borderWidth: 3) : ChangeLanguageButton(langName: chosenLang.name, langFlag: chosenLang.flag, bgColor: Color(.clear), borderColor: Color(.black), borderWidth: 1)
                    }
                    
                }
            }
            
            Button(action: {
                self.showingChosenLanguages.toggle()
            }, label: {
                Text("Confirmar")
                    .fontWeight(.semibold)
                    .font(Font.custom("Georgia", size: 25))
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            })
                .padding()
                .background(Color(red: 50/255, green: 50/255, blue: 255/255))
                .cornerRadius(40)
                .padding(.top, -200)
                    
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageView(showingChosenLanguages: .constant(true))
            .environmentObject(UserData())
    }
}
