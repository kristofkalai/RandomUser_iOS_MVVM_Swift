//
//  ImageServiceSDWebImage.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 31..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SDWebImageSwiftUI

/// The `ImageServiceProtocol` implemented by SDWebImage.
class ImageServiceSDWebImage: ImageServiceProtocol {
    
    /// Load an url into the image.
    /// - Parameters:
    ///   - url: the url in `String` format of the image.
    ///   - into: the `UIImageView` that will hold the image.
    ///   - withDelay: seconds, after the image loading will start.
    ///   - isLoadingPresenting: whether it shows a loading animation before it loaded.
    ///   - completionHandler: will be called after the image loaded.
    func load(url urlString: String, into imageView: UIImageView, withDelay delay: Double = 0.0, isLoadingPresenting loading: Bool = false, completionHandler: @escaping () -> Void = { }) {
        
//        var activityIndicator: UIActivityIndicatorView? = nil
//        if loading {
//            activityIndicator = imageView.setActivityIndicator()
//        }
//
//        guard let url = URL(string: urlString) else { return }
//
//        run(delay) {
//            imageView.sd_setImage(with: url) { (uiimage, error, cacheType, url) in
//                activityIndicator?.stopAnimating()
//                completionHandler()
//            }
//        }
    }
}
