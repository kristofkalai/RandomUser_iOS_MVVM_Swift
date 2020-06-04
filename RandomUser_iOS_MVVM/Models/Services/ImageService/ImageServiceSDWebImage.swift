//
//  ImageServiceSDWebImage.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 31..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

class ImageServiceSDWebImage {
    
    /// Load an url into the image.
    /// - Parameters:
    ///   - url: the url in `String` format of the image.
    static func load(url: String) -> some View {
        Group {
            if URL(string: url) != nil {
                WebImage(url: URL(string: url)!).resizable()
            } else {
                EmptyView()
            }
        }
    }
}
