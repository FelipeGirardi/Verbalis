//
//  OnboardingView.swift
//  Verbalis
//
//  Created by Felipe Girardi on 09/08/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @State var currentPageIndex = 0
    @Binding var isOnboardingOver: Bool
    
    var titles = ["How to use Verbalis (1)", "How to use Verbalis (2)", "How to use Verbalis (3)"]
    var captions =  ["First, select the language you want to learn. Don't worry, You can change it later.", "On the top of the screen, tap \"Languages\" to change the current language, or \"+\" to add a new word.", "Once you've added a word, you can tap it to see more translations, or swipe left to delete it."]
    var subviews = [UIHostingController(rootView: OnboardingSubview(imgString: "Onb1")),
    UIHostingController(rootView: OnboardingSubview(imgString: "Onb2")),
    UIHostingController(rootView: OnboardingSubview(imgString: "Onb3"))]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("BGElement")
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    PageVC(currentPageIndex: self.$currentPageIndex, viewControllers: self.subviews)
                        .frame(width: 200, height: 400)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("MetallicBlue"), lineWidth: 5)
                        )

                    ForEach(0..<2) { _ in
                        Spacer()
                    }

                    Rectangle()
                        .fill(Color("MetallicBlue"))
                        .frame(height: 2)
                        .edgesIgnoringSafeArea(.horizontal)
                        .padding([.leading, .trailing])

                    ForEach(0..<2) { _ in
                        Spacer()
                    }

                    Group {
                        Text(self.titles[self.currentPageIndex])
                            .customFont(name: "Georgia", style: .title2)
                        Spacer()
                        Text(self.captions[self.currentPageIndex])
                            .customFont(name: "Georgia", style: .subheadline)
                            .foregroundColor(.secondary)
                            .frame(width: 310, alignment: .leading)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    ForEach(0..<2) { _ in
                        Spacer()
                    }
                    
                    Text(self.currentPageIndex != 2 ? "Next" : "Got it!")
                        .frame(width: self.currentPageIndex != 2 ? 50 : 75, height: geometry.size.height / 50)
                        .font(Font.custom("Georgia-Bold", size: 18))
                        .foregroundColor(.white)
                        .background(Color("MetallicBlue"))
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        .background(Color("MetallicBlue"))
                        .cornerRadius(30)
                        .animation(self.animation)
                        .onTapGesture {
                            if self.currentPageIndex+1 == self.subviews.count {
                                self.isOnboardingOver = true
                            } else {
                                self.currentPageIndex += 1
                            }
                        }
                    
                    PageControl(numberOfPages: self.subviews.count, currentPageIndex: self.$currentPageIndex)
                    
                    Spacer()
                }
            }
        }
    }
    
    var animation: Animation {
        Animation.linear
            .speed(5)
            .delay(0.01)
    }
}

struct ButtonContent: View {
    var currentPageIndex: Int
    
    var body: some View {
        Text(self.currentPageIndex != 2 ? "Next" : "Got it!")
            .frame(width: self.currentPageIndex != 2 ? 40 : 50, height: 20)
            .foregroundColor(.white)
            .background(Color("MetallicBlue"))
            .buttonStyle(PlainButtonStyle())
            .padding()
            .background(Color("MetallicBlue"))
            .cornerRadius(30)
            .animation(self.animation)
//            .buttonStyle(PlainButtonStyle())
    }
    
    var animation: Animation {
        Animation.linear
            .speed(5)
            .delay(0.01)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isOnboardingOver: Binding<Bool>.constant(false))
    }
}
