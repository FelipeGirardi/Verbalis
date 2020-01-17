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
    
    var body: some View {
        return Group {
            if(isWordConfirmed) {
                TranslationScrollView()
            } else {
                AddWordView(isWordConfirmed: $isWordConfirmed)
            }
        }
    }

}

struct MainNewWordView_Previews: PreviewProvider {
    static var previews: some View {
        MainNewWordView()
    }
}
