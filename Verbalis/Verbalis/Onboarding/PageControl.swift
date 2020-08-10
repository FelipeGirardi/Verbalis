//
//  PageControl.swift
//  Verbalis
//
//  Created by Felipe Girardi on 09/08/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: Context) -> UIPageControl {
           let control = UIPageControl()
           control.numberOfPages = numberOfPages
           control.currentPageIndicatorTintColor = UIColor(named: "MetallicBlue")
           control.pageIndicatorTintColor = UIColor.lightGray

           return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
}
