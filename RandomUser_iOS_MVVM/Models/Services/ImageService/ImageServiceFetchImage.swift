//
//  ImageServiceNuke.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 31..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import FetchImage

class ImageServiceFetchImage {
    
    /// Load an url into the image.
    /// - Parameters:
    ///   - url: the url in `String` format of the image.
    static func load(url: String) -> some View {
        Group {
            if URL(string: url) != nil {
                ImageView(image: FetchImage(url: URL(string: url)!))
            } else {
                EmptyView()
            }
        }
    }
}

struct ImageView: View {
    
    @ObservedObject var image: FetchImage
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
            image.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .animation(.default)
        .onAppear(perform: image.fetch)
        .onDisappear(perform: image.cancel)
    }
}
