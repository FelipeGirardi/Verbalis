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
    var captions =  ["First, select the language you want to learn. Don't worry, You can change it later.", "You'll see two buttons: tap \"Language\" to change the current language, or \"+\" to add a new word.", "Once you've added a word, you can tap it to see more translations, or swipe left to delete it."]
    var subviews = [UIHostingController(rootView: OnboardingSubview(imgString: "Onb1")),
    UIHostingController(rootView: OnboardingSubview(imgString: "Onb2")),
    UIHostingController(rootView: OnboardingSubview(imgString: "Onb3"))]
    
    var body: some View {
        ZStack {
            Color("BGElement")
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                PageVC(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                    .frame(width: 250, height: 500)
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
                    Text(titles[currentPageIndex])
                        .customFont(name: "Georgia", style: .title2)
                    Spacer()
                    Text(captions[currentPageIndex])
                        .customFont(name: "Georgia", style: .subheadline)
                        .foregroundColor(.secondary)
                        .frame(width: 310, alignment: .leading)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        //.padding(.bottom)
                }
                
                ForEach(0..<2) { _ in
                    Spacer()
                }
                
                Text(self.currentPageIndex != 2 ? "Next" : "Got it!")
                    .frame(width: self.currentPageIndex != 2 ? 50 : 75, height: 20)
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
                
                PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
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
