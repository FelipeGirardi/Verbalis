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
    @Binding var showingAddWord: Bool
    
    @State var newWord: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Adicionar palavra")
                .font(Font.custom("Georgia", size: 25))
                .fontWeight(.medium)
                .padding()
                
                TextField("Digite palavra ", text: self.$newWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
    //            TextView(
    //                text: self.$newWord
    //            )
    //                .frame(minWidth: 0, maxWidth: geometry.size.width/2, minHeight: 0, maxHeight: 100)
                
                Button(action: {
                    //self.showingChosenLanguages.toggle()
                }, label: {
                    Text("Confirmar")
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 15))
                        .foregroundColor(Color.white)
                })
                    .padding()
                    .background(Color(red: 50/255, green: 50/255, blue: 255/255))
                    .cornerRadius(40)
                    .padding()
            }
        }
    }
}

struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordView(showingAddWord: .constant(true))
            .environmentObject(UserData())
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
