//
//  WebImage+Extensions.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

/// WebImage extension for the less code duplicate.
extension WebImage {
    
    static func configure(url: String, widthMultiplier: CGFloat = 0.8) -> some View {
        
        return WebImage(url: URL(string: url))
            .resizable()
            .placeholder(Image(systemName: "photo"))
            .indicator(.activity)
            .animation(.easeInOut(duration: 0.5))
            .transition(.fade)
            .scaledToFit()
            .frame(width: UIScreen.width * widthMultiplier)
    }
}
