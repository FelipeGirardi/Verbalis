//
//  OnboardingSubview.swift
//  Verbalis
//
//  Created by Felipe Girardi on 09/08/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct OnboardingSubview: View {
    var imgString: String
    
    var body: some View {
        GeometryReader { geometry in
            Image(self.imgString)
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .aspectRatio(contentMode: .fill)
                .clipped()
        }
    }
}

struct OnboardingSubview_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSubview(imgString: "Onb1")
    }
}
