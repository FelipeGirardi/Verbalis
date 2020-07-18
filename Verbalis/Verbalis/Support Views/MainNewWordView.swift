//
//  MainNewWordView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 16/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct MainNewWordView: View {
    @State private var isWordConfirmed = 0
    @Binding var showingAddWord: Bool
    
    var body: some View {
        return Group {
            getNewWordView()
        }
    }
    
    func getNewWordView() -> AnyView {
        switch (isWordConfirmed) {
        case 0:
            return AnyView(AddWordView(isWordConfirmed: self.$isWordConfirmed, showingAddWord: self.$showingAddWord))
        case 1:
            return AnyView(TranslationView(showingAddWord: self.$showingAddWord, isWordConfirmed: self.$isWordConfirmed))
        case 2:
            return AnyView(SynonymsView())
        default:
            return AnyView(EmptyView())
        }
    }

}

struct MainNewWordView_Previews: PreviewProvider {
    static var previews: some View {
        MainNewWordView(showingAddWord: .constant(true))
    }
}
