//
//  LanguageChoiceView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 11/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct LanguageChoiceView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    @State var currentLanguageId: Int
    @State var langWasChosen: Bool
    @Binding var choiceMade: Bool
    @Binding var showingChosenLanguages: Bool
    var isInitialView: Bool
    
    @FetchRequest(entity: Language.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)],
                  predicate: NSPredicate(format: "isChosen == %@", NSNumber(value: true)))
    var langsChosenResults: FetchedResults<Language>
    
    var langsChosenResultsArray: [Language] {
        Array(self.langsChosenResults)
    }
    
    var animation: Animation {
        Animation.linear
            .speed(5)
            .delay(0.01)
    }
    
    var cancelButton: some View {
        Button(action: {
            self.showingChosenLanguages.toggle()
        }, label: {
            Text("Exit")
                .font(.system(size: 20))
        })
    }
    
    func calculateRowColumn(row: Int, column: Int) -> Int {
        return row * 2 + column
    }
    
    fileprivate func mainLanguageButton(row: Int, column: Int, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        let isCurrentlyPicked: Bool
        if(isInitialView) {
            isCurrentlyPicked = self.userData.languages[self.calculateRowColumn(row: row, column: column)].id == self.currentLanguageId
        } else {
            isCurrentlyPicked = self.langsChosenResultsArray[self.calculateRowColumn(row: row, column: column)].id == self.currentLanguageId
        }
        
        return Button(action: {
            if(!self.langWasChosen) {
                self.langWasChosen = true
            } else {
                if(self.isInitialView) {
                    self.userData.languages[self.currentLanguageId].isCurrent = false
                } else {
                    self.langsChosenResultsArray[self.currentLanguageId].isCurrent = false
                }
            }
            
            self.currentLanguageId = self.calculateRowColumn(row: row, column: column)
            if(self.isInitialView) {
                self.userData.languages[self.currentLanguageId].isCurrent = true
            } else {
                self.langsChosenResultsArray[self.currentLanguageId].isCurrent = true
            }
        }) {
            self.isInitialView ?
                
                LanguageSelectorView(language: self.userData.languages[self.calculateRowColumn(row: row, column: column)].name ?? "", flag: self.userData.languages[self.calculateRowColumn(row: row, column: column)].flag ?? "", isButtonPressed: isCurrentlyPicked, screenWidth: screenWidth, screenHeight: screenHeight)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                
                :
                
                LanguageSelectorView(language: self.langsChosenResultsArray[self.calculateRowColumn(row: row, column: column)].name ?? "", flag: self.langsChosenResultsArray[self.calculateRowColumn(row: row, column: column)].flag ?? "", isButtonPressed: isCurrentlyPicked, screenWidth: screenWidth, screenHeight: screenHeight)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .foregroundColor(Color("BGElement"))
        .scaleEffect(isCurrentlyPicked ? 0.95 : 1.0)
        .animation(.spring())
    }
    
    var body: some View {
        GeometryReader { geometry in
        NavigationView {
            ZStack {
                Color("BGElement")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text(self.isInitialView ? "Hello!\n\nWhat language are you learning?" : "What language are you learning?")
                        .customFont(name: "Georgia", style: .title2, weight: .bold)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                    
                    Spacer()
                    
                    ForEach(0 ..< 3) { row in
                        HStack {
                            ForEach(0 ..< 2) { column in
                                self.mainLanguageButton(row: row, column: column, screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        // Mark all languages as chosen to prevent duplication later
                        if(self.isInitialView) {
                            for lang in self.userData.languages {
                                lang.isChosen = true
                            }
                            self.choiceMade.toggle()
                            UserDefaults.standard.set(true, forKey: "choiceMade")
                        } else {
                            for lang in self.langsChosenResults {
                                lang.isCurrent = (lang.id == self.currentLanguageId) ? true : false
                            }
                            self.showingChosenLanguages.toggle()
                        }

                        UserDefaults.standard.set(self.currentLanguageId, forKey: "currentLanguageId")
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print("Could not save language info to CoreData")
                            print(error)
                        }
                        
                    }, label: {
                        Text(self.isInitialView ? "Start" : "Confirm")
                            .fontWeight(.semibold)
                            .customFont(name: "Georgia", style: .title2, weight: .semibold)
                            .foregroundColor(self.langWasChosen ? Color.white : Color.black)
                            .frame(minWidth: 0, maxWidth: geometry.size.width/1.5, minHeight: 0, maxHeight: geometry.size.height/15)
                            //.padding(EdgeInsets(top: 10, leading: 110, bottom: 10, trailing: 110))
                    })
                    .disabled(!self.langWasChosen)
                    .background(self.langWasChosen ? Color("MetallicBlue") : Color.gray)
                    .cornerRadius(20)
                    .opacity(self.langWasChosen ? 1.0 : 0.25)
                    .animation(self.animation)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(self.langWasChosen ? Color("Main") : Color("DarkShadow"), lineWidth: 2)
                            .blur(radius: 4)
                            .offset(x: 0, y: 2)
                    )
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    
                    Spacer()
                }
                .navigationBarTitle(Text("Change language"), displayMode: .inline)
                .navigationBarItems(
                    trailing: self.cancelButton
                )
                .navigationBarHidden(self.isInitialView)
                .onAppear() {
                    if(self.isInitialView) {
                        for row in (0 ..< 3) {
                            for column in (0 ..< 2) {
                                let position = self.calculateRowColumn(row: row, column: column)
                                self.userData.languages[position].id = Int16(position)
                            }
                        }
                    }
                }
            }
        }
    }
    }
}

struct LanguageChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}

// - MARK: dynamic custom font extension

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct CustomFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    var name: String
    var style: UIFont.TextStyle
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        return content.font(Font.custom(
            name,
            size: UIFont.preferredFont(forTextStyle: style).pointSize)
            .weight(weight))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func customFont(
        name: String,
        style: UIFont.TextStyle,
        weight: Font.Weight = .regular) -> some View {
        return self.modifier(CustomFont(name: name, style: style, weight: weight))
    }
}
