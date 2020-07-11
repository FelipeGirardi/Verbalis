//
//  ChangeLanguageButton.swift
//  WordsApp
//
//  Created by Felipe Girardi on 15/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct ChangeLanguageButton: View {
    @Binding var langState: Int
    var chosenLang: Language
    
    func buttonLabel(langName: String, langFlag: String, textColor: Color) -> some View {
        return HStack {
                Spacer()
                Text(langFlag + " " + langName + " " + langFlag)
                    .fontWeight(.semibold)
                    .font(Font.custom("Georgia", size: 15))
                    .foregroundColor(textColor)
                    .padding(10)
                Spacer()
            }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 40)
                .fill(chosenLang.id == self.langState ? Color(red: 64/255, green: 0/255, blue: 255/255) : Color(.white))
                .shadow(color: Color.black, radius: chosenLang.id == self.langState ? 3 : 1.5, x: 0, y: chosenLang.id == self.langState ? 3 : 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black, lineWidth: chosenLang.id == self.langState ? 2 : 1)
            )
            
            chosenLang.id == self.langState ?
                buttonLabel(langName: chosenLang.name ?? "", langFlag: chosenLang.flag ?? "", textColor: Color.white) :
                buttonLabel(langName: chosenLang.name ?? "", langFlag: chosenLang.flag ?? "", textColor: Color.black)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                self.langState = Int(self.chosenLang.id)
            }
        }
    }
}

struct ChangeLanguageButton_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
