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
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
            ZStack {
            Group {
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .dark ? (self.isButtonPressed ? Color("MetallicBlue") : Color("BGElement")) : Color("BGElement"))
                    .frame(minWidth: 0, maxWidth: screenWidth/3, minHeight: 0, maxHeight: screenHeight/6)
                    // Outer shadows
                    .shadow(color: self.isButtonPressed ? (colorScheme == .dark ? Color.black : Color("MetallicBlue")) : Color("DarkShadow"), radius: self.isButtonPressed ? 1 : 5, x: self.isButtonPressed ? -1 : -5, y: self.isButtonPressed ? -1 : -5)
                    .shadow(color: self.isButtonPressed ? (colorScheme == .dark ? Color.black : Color("MetallicBlue")) : Color("LightShadow"), radius: self.isButtonPressed ? 1 : 5, x: self.isButtonPressed ? 1 : 5, y: self.isButtonPressed ? 1 : 5)
                    // Inner shadows
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(colorScheme == .dark ? Color.black : Color("MetallicBlue"), lineWidth: self.isButtonPressed ? (colorScheme == .dark ? 5 : 12.5) : 0)
                            .blur(radius: colorScheme == .dark ? 3 : 4.5)
                            .offset(x: colorScheme == .dark ? 1 : 0, y: colorScheme == .dark ? 1 : 0)
                            .mask(RoundedRectangle(cornerRadius: 20).fill(self.isButtonPressed ? LinearGradient(colorScheme == .dark ? Color.black : Color("MetallicBlue"), Color.clear) : LinearGradient(Color.clear, Color.clear)))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(colorScheme == .dark ? Color.black : Color("MetallicBlue"), lineWidth: self.isButtonPressed ? (colorScheme == .dark ? 5 : 12.5) : 0)
                            .blur(radius: colorScheme == .dark ? 3 : 4.5)
                            .offset(x: colorScheme == .dark ? -1 : 0, y: colorScheme == .dark ? -1 : 0)
                            .mask(RoundedRectangle(cornerRadius: 20).fill(self.isButtonPressed ? LinearGradient(Color.clear, colorScheme == .dark ? Color.black : Color("MetallicBlue")) : LinearGradient(Color.clear, Color.clear)))
                    )
                    .accessibility(hint: self.isButtonPressed ? Text("Selected") : Text("NotSelected"))
                    .accessibility(addTraits: .startsMediaSession)
            }
                VStack {
                    Text(self.language)
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 16))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color("Main"))
                        .padding(.top, 10)
                        .accessibility(label: Text(self.language + ", "))

                    Text(self.flag)
                        .font(.system(size: 55))
                        .minimumScaleFactor(0.5)
                        .accessibility(label: Text(self.flag))
                }
            }
    }
}

struct LanguageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LanguageSelectorView(language: languageData[0].name ?? "", flag: languageData[0].flag ?? "", isButtonPressed: false, screenWidth: 160, screenHeight: 160)
            LanguageSelectorView(language: languageData[1].name ?? "", flag: languageData[1].flag ?? "", isButtonPressed: false, screenWidth: 160, screenHeight: 160)
            LanguageSelectorView(language: languageData[2].name ?? "", flag: languageData[2].flag ?? "", isButtonPressed: false, screenWidth: 160, screenHeight: 160)
            LanguageSelectorView(language: languageData[3].name ?? "", flag: languageData[3].flag ?? "", isButtonPressed: false, screenWidth: 160, screenHeight: 160)
            LanguageSelectorView(language: languageData[4].name ?? "", flag: languageData[4].flag ?? "", isButtonPressed: false, screenWidth: 160, screenHeight: 160)
            LanguageSelectorView(language: languageData[5].name ?? "", flag: languageData[5].flag ?? "", isButtonPressed: false, screenWidth: 160, screenHeight: 160)
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
