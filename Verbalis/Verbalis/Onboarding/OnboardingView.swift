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
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var captions: [String] =  []
    var subviews = [UIHostingController(rootView: OnboardingSubview(imgString: "Onb1")),
    UIHostingController(rootView: OnboardingSubview(imgString: "Onb2")),
    UIHostingController(rootView: OnboardingSubview(imgString: "Onb3"))]
    
    init(isOnboardingOver: Binding<Bool>) {
        self._isOnboardingOver = isOnboardingOver
        self.captions = [String(format: NSLocalizedString("OnboardingStep1", comment: "How to select language")), String(format: NSLocalizedString("OnboardingStep2", comment: "How to use tab bar buttons")), String(format: NSLocalizedString("OnboardingStep3", comment: "How to deal with words on main screen"))]
    }
    
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
                        Text(NSLocalizedString("How to use Verbalis", comment: "How to use the app"))
                            .customFont(name: "Georgia", style: .title2)
                        
                        Spacer()
                        
                        Text(self.captions[self.currentPageIndex])
                            .customFont(name: "Georgia", style: .subheadline)
                            .foregroundColor(.secondary)
                            .frame(width: geometry.size.width/1.5)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    ForEach(0..<2) { _ in
                        Spacer()
                    }
                    
                    Text(self.currentPageIndex != 2 ? NSLocalizedString("Next", comment: "Next step") : NSLocalizedString("GotIt", comment: "Finish onboarding"))
                        .frame(minHeight: 0, maxHeight: geometry.size.height/20)
                        .padding([.leading, .trailing])
                        .font(Font.custom("Georgia-Bold", size: 18))
                        .foregroundColor(.white)
                        .background(Color("MetallicBlue"))
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(30)
                        .animation(self.animation)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("Main"), lineWidth: 0.5)
                                .blur(radius: 3)
                                .offset(x: 0, y: 2)
                        )
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
            .cornerRadius(30)
            .animation(self.animation)
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
