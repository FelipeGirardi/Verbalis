//
//  LanguageSelectorView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 12/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct LanguageSelectorView: View {
    var language: String
    var flag: String
    var isButtonPressed: Bool
    
    var body: some View {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(("BGElement")))
                    .frame(width: 130, height: 130)
                    .shadow(color: Color("DarkShadow"), radius: self.isButtonPressed ? 0 : 10, x: self.isButtonPressed ? 0 : -10, y: self.isButtonPressed ? 0 : -10)
                    .shadow(color: Color("LightShadow"), radius: self.isButtonPressed ? 0 : 10, x: self.isButtonPressed ? 0 : 10, y: self.isButtonPressed ? 0 : 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("DarkShadow"), lineWidth: self.isButtonPressed ? 10 : 0)
                            .blur(radius: 2)
                            .offset(x: 1, y: 1)
                            .mask(RoundedRectangle(cornerRadius: 20).fill(self.isButtonPressed ? LinearGradient(Color("DarkShadow"), Color.clear) : LinearGradient(Color.clear, Color.clear)))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("LightShadow"), lineWidth: self.isButtonPressed ? 10 : 0)
                            .blur(radius: 2)
                            .offset(x: -1, y: -1)
                            .mask(RoundedRectangle(cornerRadius: 20).fill(self.isButtonPressed ? LinearGradient(Color.clear, Color("DarkShadow")) : LinearGradient(Color.clear, Color.clear)))
                    )
            }
            .overlay(
                Group {
                    Text(language)
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 18))
                        .padding(.top, 15)
                        .foregroundColor(Color("Main"))

                    Text(flag)
                        .font(.system(size: 60))
                }
            )
    }
}

struct LanguageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LanguageSelectorView(language: languageData[0].name ?? "", flag: languageData[0].flag ?? "", isButtonPressed: false)
            LanguageSelectorView(language: languageData[1].name ?? "", flag: languageData[1].flag ?? "", isButtonPressed: false)
            LanguageSelectorView(language: languageData[2].name ?? "", flag: languageData[2].flag ?? "", isButtonPressed: false)
            LanguageSelectorView(language: languageData[3].name ?? "", flag: languageData[3].flag ?? "", isButtonPressed: false)
            LanguageSelectorView(language: languageData[4].name ?? "", flag: languageData[4].flag ?? "", isButtonPressed: false)
            LanguageSelectorView(language: languageData[5].name ?? "", flag: languageData[5].flag ?? "", isButtonPressed: false)
        }
        .previewLayout(.fixed(width: 160, height: 160))
    }
}

// - MARK: inner shadow extension

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
