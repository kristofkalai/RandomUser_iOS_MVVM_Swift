//
//  ImageServiceProtocols.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 06. 01..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import UIKit

// MARK: - ImageService part.
protocol ImageServiceProtocol {
    
    /// Load an url into the image.
    /// - Parameters:
    ///   - url: the url in `String` format of the image.
    ///   - into: the `UIImageView` that will hold the image.
    ///   - withDelay: seconds, after the image loading will start.
    ///   - isLoadingPresenting: whether it shows a loading animation before it loaded.
    ///   - completionHandler: will be called after the image loaded.
    func load(url urlString: String, into imageView: UIImageView, withDelay delay: Double, isLoadingPresenting loading: Bool, completionHandler: @escaping () -> Void)
}

extension ImageServiceProtocol {
    
    /// Load an url into the image. It's the customization of the `ImageServiceContainerProtocol`'s `load(url:into:withdelay:isloadingPresenting:completionHandler:)` method.
    /// - Parameters:
    ///   - withDelay: optional argument, by default it is 0.0.
    ///   - isLoadingPresenting: optional argument, by default it is false.
    ///   - completionHandler: optional argument, by default it does nothing.
    func load(url urlString: String, into imageView: UIImageView, withDelay delay: Double = 0.0, isLoadingPresenting loading: Bool = false, completionHandler: @escaping () -> Void = { }) {
        load(url: urlString, into: imageView, withDelay: delay, isLoadingPresenting: loading, completionHandler: completionHandler)
    }
}
