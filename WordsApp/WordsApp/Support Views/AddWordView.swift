//
//  AddWordView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 15/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI
import Combine

struct AddWordView: View {
    @EnvironmentObject var userData: UserData
    @Binding var showingAddWord: Bool
    @State var newWord: String = ""
    @State var confirmButtonClicked: Bool = false
//    @ObservedObject var addWordViewModel: AddWordViewModel = AddWordViewModel()
    
    var cancelButton: some View {
        Button(action: {
            self.showingAddWord.toggle()
        }, label: {
            Text("Exit")
                .font(.system(size: 20))
        })
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Which word would you like to add?")
                    .font(Font.custom("Georgia", size: 25))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()
                
                TextField("Type here", text: self.$newWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    self.confirmButtonClicked = true
                    self.userData.fetchWordData(word: self.newWord, langCode: self.userData.currentLanguageCode, completion: {  (result) -> (Void) in
                        switch(result) {
                        case .failure(let error):
                            print("Error")
                            print(error.localizedDescription)
                        case .success(_):
                            self.showingAddWord.toggle()
                        }
                    })
                }, label: {
                    Text(confirmButtonClicked ? "Saving..." : "Confirm")
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 20))
                        .foregroundColor(confirmButtonClicked ? Color.black : Color.white)
                })
                    .padding()
                    .background(confirmButtonClicked ? Color(red: 255/255, green: 255/255, blue: 255/255) : Color(red: 50/255, green: 50/255, blue: 255/255))
                    .cornerRadius(40)
                    .padding()
                    .disabled(confirmButtonClicked)
            }
            .navigationBarTitle(Text("New word"), displayMode: .inline)
            .navigationBarItems(
                trailing: cancelButton
            )
        }
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView(showingAddWord: .constant(true))
            .environmentObject(UserData())
    }
}
