//
//  MainNewWordView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 16/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct MainNewWordView: View {
    @State private var isWordConfirmed = false
    @Binding var showingAddWord: Bool
    
    var body: some View {
        return Group {
            if(isWordConfirmed) {
                TranslationView(showingAddWord: self.$showingAddWord)
            } else {
                AddWordView(isWordConfirmed: self.$isWordConfirmed, showingAddWord: self.$showingAddWord)
            }
        }
    }

}

struct MainNewWordView_Previews: PreviewProvider {
    static var previews: some View {
        MainNewWordView(showingAddWord: .constant(true))
    }
}
