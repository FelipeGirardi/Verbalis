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
    @State var savingWordState: SavingWordState = .none
    var currentLangCode: String
    
    func getStateLabel() -> Text {
        switch(savingWordState) {
        case .none:
            return Text("...")
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color.white)
        case .saving:
            return Text("Saving...")
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
        case .saveSuccess:
            return Text("Word saved!")
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color.green)
        case .saveFailure:
            return Text("Word not found.")
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color.red)
        case .duplicateSave:
            return Text("Word already added.")
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color.red)
        }
    }
    
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
                    .padding()
                
                TextField("Type here", text: self.$newWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    self.confirmButtonClicked = true
                    self.savingWordState = .saving
                    
                    self.userData.fetchWordData(word: self.newWord, langCode: self.currentLangCode, completion: { (result) -> (Void) in
                        switch(result) {
                        case .saveSuccess:
                            self.savingWordState = .saveSuccess
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.showingAddWord.toggle()
                            }
                        case .saveFailure:
                            self.savingWordState = .saveFailure
                            self.confirmButtonClicked = false
                            
                        case .duplicateSave:
                            self.savingWordState = .duplicateSave
                            self.confirmButtonClicked = false
                            
                        default:
                            self.savingWordState = .saveFailure
                            self.confirmButtonClicked = false
                        }
                    })
                }, label: {
                    Text("Confirm")
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 20))
                        .foregroundColor(Color.white)
                })
                    .padding()
                    .background(Color(red: 64/255, green: 0/255, blue: 255/255))
                    .opacity((confirmButtonClicked || self.newWord == "") ? 0.2 : 1.0)
                    .cornerRadius(40)
                    .shadow(color: (confirmButtonClicked || self.newWord == "") ? Color.clear : Color.black, radius: 3, x: 0, y: 2)
                    .disabled(confirmButtonClicked || self.newWord == "")
                    .padding()
                    //.padding()
                    //.padding()
                
                // MARK: Label that marks the state of word being saved
                getStateLabel()
                    .padding()
                    .padding()
                
            }
            .navigationBarTitle(Text("New word"), displayMode: .inline)
            .navigationBarItems(
                trailing: cancelButton
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
//        AddWordView(showingAddWord: .constant(true), currentLangCode: "de")
//            .environmentObject(UserData())
    }
}
