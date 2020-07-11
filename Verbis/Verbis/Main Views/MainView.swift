//
//  MainView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 13/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @EnvironmentObject var userData: UserData
    @State private var choiceMade = false
    
    func initialSaveToCoreData() {
        let moc = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Language")
        fetchRequest.predicate = NSPredicate(format: "isChosen == %@", NSNumber(value: true))
        
        do {
            try moc.save()
        } catch _ {
            fatalError()
        }
    }
    
    var body: some View {
        return Group {
            if(choiceMade || UserDefaults.standard.bool(forKey: "choiceMade")) {
                MainWordsView()
            } else {
                LanguageChoiceView(currentLanguageId: -1, langWasChosen: false, choiceMade: $choiceMade, showingChosenLanguages: Binding<Bool>.constant(false), isInitialView: true)
            }
        }
        .onAppear() {
            self.initialSaveToCoreData()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserData())
    }
}
