//
//  TranslationScrollView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 16/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct TranslationView: View {
    @Binding var showingAddWord: Bool
    @Binding var isWordConfirmed: Int
    @State var translations: [String] = ["", "", "", "", ""]
    @State var nTranslations: Int = 1
    @EnvironmentObject var userData: UserData
    
    var cancelButton: some View {
        Button(action: {
            self.showingAddWord.toggle()
        }, label: {
            Text("Sair")
                .font(.system(size: 20))
        })
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Text("Digite traduções para \"\(self.userData.currentWord)\":")
                        .font(Font.custom("Georgia", size: 20))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding()
                        
                    ForEach(Array(1...self.nTranslations), id: \.self) { index in
                        TextField("Tradução \(index)", text: self.$translations[index-1])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    
                    if(self.nTranslations < 5) {
                        Button(action: {
                            self.nTranslations += 1
                        }, label: {
                            Text("Inserir nova tradução")
                                .fontWeight(.semibold)
                                .font(Font.custom("Georgia", size: 10))
                                .foregroundColor(Color.white)
                        })
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(Color(red: 50/255, green: 50/255, blue: 255/255))
                        .cornerRadius(40)
                    }
                    
                    Button(action: {
                        // MARK: Add translations to UserData
                        self.isWordConfirmed = 2
                    }, label: {
                        Text("Próximo")
                            .fontWeight(.semibold)
                            .font(Font.custom("Georgia", size: 15))
                            .foregroundColor(Color.white)
                    })
                        .padding()
                        .background(Color(red: 50/255, green: 50/255, blue: 255/255))
                        .cornerRadius(40)
                        .padding(EdgeInsets(top: 100, leading: 15, bottom: 15, trailing: 15))
                    
//                    TextView(
//                        text: self.$translation
//                    )
//                        .frame(minWidth: 0, maxWidth: geometry.size.width/2, minHeight: 0, maxHeight: 30)
                }
                .navigationBarTitle(Text("Nova palavra"), displayMode: .inline)
                .navigationBarItems(
                    trailing: self.cancelButton
                )
            }
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(showingAddWord: .constant(true), isWordConfirmed: .constant(1))
    }
}

//struct TextView: UIViewRepresentable {
//    @Binding var text: String
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> UITextView {
//
//        let myTextView = UITextView()
//        myTextView.delegate = context.coordinator
//
//        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
//        myTextView.isScrollEnabled = true
//        myTextView.isEditable = true
//        myTextView.isUserInteractionEnabled = true
//        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)
//
//        return myTextView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        uiView.text = text
//    }
//
//    class Coordinator : NSObject, UITextViewDelegate {
//
//        var parent: TextView
//
//        init(_ uiTextView: TextView) {
//            self.parent = uiTextView
//        }
//
//        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//            return true
//        }
//
//        func textViewDidChange(_ textView: UITextView) {
//            print("text now: \(String(describing: textView.text!))")
//            self.parent.text = textView.text
//        }
//    }
//}
