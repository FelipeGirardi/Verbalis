//
//  MainView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 13/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State var choiceMade = false
    
    var body: some View {
        return Group {
            if(choiceMade) {
                MainWordsView()
            } else {
                LanguageChoiceView(choiceMade: $choiceMade)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
