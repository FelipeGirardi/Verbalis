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
    
    var animation: Animation {
        Animation.linear
            .speed(5)
            .delay(0.01)
    }
    
    func getStateLabel() -> Text {
        switch(savingWordState) {
        case .none:
            return Text("...")
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color("BGElement"))
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
            ZStack {
                Color("BGElement")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Which word would you like to add?")
                        .font(Font.custom("Georgia", size: 25))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.bottom)
                    
                    TextField("Type here", text: self.$newWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .padding(.top)
                        .padding(.bottom)
                    
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
                            .foregroundColor((confirmButtonClicked || self.newWord == "") ? Color.black : Color.white)
                            .opacity((confirmButtonClicked || self.newWord == "") ? 0.5 : 1.0)
                            .padding(EdgeInsets(top: 10, leading: 110, bottom: 10, trailing: 110))
                    })
                        .disabled(confirmButtonClicked || self.newWord == "")
                        .background(confirmButtonClicked || self.newWord == "" ? Color.gray : Color("MetallicBlue"))
                        .opacity((confirmButtonClicked || self.newWord == "") ? 0.2 : 1.0)
                        .cornerRadius(20)
                        .animation(self.animation)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke((confirmButtonClicked || self.newWord == "") ? Color("DarkShadow") : Color("Main"), lineWidth: 2)
                                .blur(radius: 4)
                                .offset(x: 0, y: 2)
                        )
                        .padding()
                        .padding(.top)
                        .padding(.bottom)
                    
                    // MARK: Label that marks the state of word being saved
                    getStateLabel()
                        .padding()
                        .padding(.top)
                }
                .navigationBarTitle(Text("New word"), displayMode: .inline)
                .navigationBarItems(
                    trailing: cancelButton
                )
            }
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
