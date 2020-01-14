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
    
    var body: some View {
            VStack {
                Text(language)
                    .fontWeight(.semibold)
                    .font(Font.custom("Georgia", size: 22))
                    //.font(.system(size: 24))
                    .padding(.top, 15)
                    .foregroundColor(.black)

                Text(flag)
                    .font(.system(size: 70))
                
            }
            .fixedSize()
            .frame(width: 150, height: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color(red: 30/255, green: 220/255, blue: 255/255), lineWidth: 10)
            )
    }
}

struct LanguageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LanguageSelectorView(language: languageData[0].name, flag: languageData[0].flag)
            LanguageSelectorView(language: languageData[1].name, flag: languageData[1].flag)
            LanguageSelectorView(language: languageData[2].name, flag: languageData[2].flag)
            LanguageSelectorView(language: languageData[3].name, flag: languageData[3].flag)
            LanguageSelectorView(language: languageData[4].name, flag: languageData[4].flag)
            LanguageSelectorView(language: languageData[5].name, flag: languageData[5].flag)
        }
        .previewLayout(.fixed(width: 160, height: 160))
    }
}
