//
//  LanguageChoiceView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 11/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct LanguageChoiceView: View {
    
    func calculateRowColumn(row: Int, column: Int) -> Int {
        return row * 2 + column
    }
    
    @State private var selectedLanguage = 0
    
    var body: some View {
        
            VStack {
                Text("Qual língua você está aprendendo?")
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                    .padding(.top, CGFloat(50))
                    //.padding(.bottom, CGFloat(100))
                
                Spacer()
                
                    ForEach(0 ..< 3) { row in
                        HStack {
                            ForEach(0 ..< 2) { column in
                                LanguageSelectorView(language: languages[self.calculateRowColumn(row: row, column: column)], flag: flags[self.calculateRowColumn(row: row, column: column)])
                                .padding()
                            }
                        }
                    }
                
                Spacer()
                
                Button(action: {
                                
                }, label: {
                    Text("Começar")
                    .fontWeight(.semibold)
                })
                .font(.system(size: 20))
                .foregroundColor(Color.black)
                .padding()
                //.padding()
                .background(Color(red: 30/255, green: 220/255, blue: 255/255))
                .cornerRadius(40)
                .padding(.bottom, 20)
                
            }
    }
}

struct LanguageChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageChoiceView()
    }
}
