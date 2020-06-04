//
//  ImageProvider.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 31..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import UIKit

// MARK: - Manages downloading images in the app.
class ImageServiceContainer {
    
    /// Supports the 3 major external libraries.
    enum ISType {
        case fetchimage
        case kingfisher
        case sdwebimage
    }
    
    let service: ImageServiceProtocol
    
    init(_ isType: ISType = .fetchimage) {
        switch isType {
        case .fetchimage:
            service = ImageServiceFetchImage()
        case .kingfisher:
            service = ImageServiceKingfisher()
        case .sdwebimage:
            service = ImageServiceSDWebImage()
        }
    }
}
