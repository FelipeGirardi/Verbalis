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
        Image(imgString)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
            //.border(Color("MetallicBlue"), width: 4)
    }
}

struct OnboardingSubview_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSubview(imgString: "Onb1")
    }
}
