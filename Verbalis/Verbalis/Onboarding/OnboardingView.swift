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
    var subviews = [UIHostingController(rootView: OnboardingSubview(imgString: "Onboarding1")),
    UIHostingController(rootView: OnboardingSubview(imgString: "Onboarding2")),
    UIHostingController(rootView: OnboardingSubview(imgString: "Onboarding3"))]
    
    var body: some View {
        ZStack {
            Color("BGElement")
                .edgesIgnoringSafeArea(.all)

            VStack {
                PageVC(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                    .frame(height: 500)
                Rectangle()
                    .fill(Color("MetallicBlue"))
                    .frame(height: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding()
                    .padding(.bottom)
                Group {
                    Text(titles[currentPageIndex])
                        .customFont(name: "Georgia", style: .title2)
                    
                    Text(captions[currentPageIndex])
                        .customFont(name: "Georgia", style: .subheadline)
                        .foregroundColor(.gray)
                        .frame(width: 310, height: 70, alignment: .leading)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.bottom)
                
                Button(action: {
                    if self.currentPageIndex+1 == self.subviews.count {
                        self.isOnboardingOver = true
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    ButtonContent()
                }
                
                PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
            }
        }
    }
}

struct ButtonContent: View {
    var body: some View {
    Image(systemName: "arrow.right")
            .resizable()
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .padding()
            .background(Color("MetallicBlue"))
            .cornerRadius(30)
        }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isOnboardingOver: Binding<Bool>.constant(false))
    }
}
