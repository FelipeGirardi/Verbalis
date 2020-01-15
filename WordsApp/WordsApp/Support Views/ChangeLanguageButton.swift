//
//  ChangeLanguageButton.swift
//  WordsApp
//
//  Created by Felipe Girardi on 15/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct ChangeLanguageButton: View {
    var langName: String
    var langFlag: String
    var bgColor: Color
    var borderColor: Color
    var borderWidth: CGFloat
    
    var rectangle: some View {
        RoundedRectangle(cornerRadius: 40)
            .stroke(borderColor, lineWidth: borderWidth)
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text(langFlag + langName + langFlag)
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 15))
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            Spacer()
        }
        .background(bgColor)
        .cornerRadius(40)
        .overlay(
            rectangle
        )
    }
}

struct ChangeLanguageButton_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageButton(langName: "Inglês", langFlag: "🇪🇺", bgColor: Color(.yellow), borderColor: Color(.blue), borderWidth: 3)
    }
}
