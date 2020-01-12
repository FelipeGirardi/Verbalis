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
                    .font(.system(size: 25))
                    .padding(.top, 15)

                Text(flag)
                    .font(.system(size: 70))
            }
            .fixedSize()
            .frame(width: 150, height: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color(red: 30/255, green: 220/255, blue: 255/255), lineWidth: 8)
            )
        
    }
    
}

struct LanguageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LanguageSelectorView(language: languages[0], flag: flags[0])
            LanguageSelectorView(language: languages[1], flag: flags[1])
            LanguageSelectorView(language: languages[2], flag: flags[2])
            LanguageSelectorView(language: languages[3], flag: flags[3])
            LanguageSelectorView(language: languages[4], flag: flags[4])
            LanguageSelectorView(language: languages[5], flag: flags[5])
        }
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
