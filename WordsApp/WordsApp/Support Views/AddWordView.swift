//
//  AddWordView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 15/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct AddWordView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isWordConfirmed: Bool
    @Binding var showingAddWord: Bool
    @State var newWord: String = ""
    
    var cancelButton: some View {
        Button(action: {
            self.showingAddWord.toggle()
        }, label: {
            Text("Sair")
                .font(.system(size: 20))
        })
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Qual palavra ou expressão deseja adicionar?")
                    .font(Font.custom("Georgia", size: 25))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
                
                TextField("Digite aqui", text: self.$newWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    self.userData.currentWord = self.newWord
                    self.isWordConfirmed.toggle()
                }, label: {
                    Text("Próximo")
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 15))
                        .foregroundColor(Color.white)
                })
                    .padding()
                    .background(Color(red: 50/255, green: 50/255, blue: 255/255))
                    .cornerRadius(40)
                    .padding()
            }
            .navigationBarTitle(Text("Nova palavra"), displayMode: .inline)
            .navigationBarItems(
                trailing: cancelButton
            )
        }
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView(isWordConfirmed: .constant(true), showingAddWord: .constant(true))
            .environmentObject(UserData())
    }
}
