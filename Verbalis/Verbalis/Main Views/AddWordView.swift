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
    
    var isConfirmButtonDisabled: Bool {
        confirmButtonClicked || self.newWord == ""
    }
    
    var animation: Animation {
        Animation.linear
            .speed(5)
            .delay(0.01)
    }
    
    func getStateLabel() -> some View {
        switch(savingWordState) {
        case .none:
            return Text("...")
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color("BGElement"))
        case .saving:
            return Text(NSLocalizedString("Saving", comment: "Saving the word"))
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
        case .saveSuccess:
            return Text(NSLocalizedString("Saved", comment: "Word was saved"))
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color.green)
        case .saveFailure:
            return Text(NSLocalizedString("NotFound", comment: "Word was not found"))
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color.red)
        case .duplicateSave:
            return Text(NSLocalizedString("AlreadyAdded", comment: "Word has already been added"))
                .fontWeight(.semibold)
                .font(Font.custom("Georgia", size: 20))
                .foregroundColor(Color.red)
        }
    }
    
    var cancelButton: some View {
        Button(action: {
            self.showingAddWord.toggle()
        }, label: {
            Text(NSLocalizedString("Exit", comment: "Exit the screen"))
                .font(.system(size: 20))
        })
    }
    
    fileprivate func confirmButton(maxWidth: CGFloat, maxHeight: CGFloat) -> some View {
        return
            Text(NSLocalizedString("Confirm", comment: "Confirm word"))
                .frame(minWidth: 0, maxWidth: maxWidth, minHeight: 0, maxHeight: maxHeight)
                .customFont(name: "Georgia", style: .title2, weight: .semibold)
                .foregroundColor(self.isConfirmButtonDisabled ? Color.black : Color.white)
        
                .buttonStyle(PlainButtonStyle())
                .disabled(self.isConfirmButtonDisabled)
                .background(self.isConfirmButtonDisabled ? Color.gray : Color("MetallicBlue"))
                .opacity(self.isConfirmButtonDisabled ? 0.25 : 1.0)
                .cornerRadius(20)
                .animation(self.animation)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(self.isConfirmButtonDisabled ? Color("DarkShadow") : Color("Main"), lineWidth: 1.5)
                        .blur(radius: 3)
                        .offset(x: 0, y: 1)
                )
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .onTapGesture {
                    self.endEditing()
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
                }
    }
    
    struct Background<Content: View>: View {
        private var content: Content

        init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content()
        }

        var body: some View {
            Color.white
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("BGElement")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        
                        VStack {
                            Text(NSLocalizedString("AddWord", comment: "Ask user which word they would like to add"))
                                .font(Font.custom("Georgia", size: 25))
                                .fontWeight(.medium)
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .padding(.bottom)
                            
                            //Spacer()
                            
                            TextField(NSLocalizedString("TypeHere", comment: "Tell user to type here"), text: self.$newWord) {
                                self.endEditing()
                            }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .padding()
                            
                            //Spacer()
                            
                            self.confirmButton(maxWidth: geometry.size.width/1.5, maxHeight: geometry.size.height/15)
                            .padding(.top)
                        }
                        
                        Spacer()
                        
                        // MARK: Label that marks the state of word being saved
                        HStack {
                            self.getStateLabel()

                            ActivityIndicator(isAnimating: .constant(self.savingWordState == .saving), style: .medium)
                                .opacity(self.savingWordState == .saving ? 1 : 0)
                        }
                        
                        Spacer()
                        Spacer()
                    }
                    .navigationBarTitle(Text(NSLocalizedString("NewWord", comment: "New word title for sheet")), displayMode: .inline)
                    .navigationBarItems(
                        trailing: self.cancelButton
                    )
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .onTapGesture {
            self.endEditing()
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// - MARK: loading indicator

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
//        AddWordView(showingAddWord: .constant(true), currentLangCode: "de")
//            .environmentObject(UserData())
    }
}
