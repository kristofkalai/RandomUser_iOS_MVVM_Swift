//
//  View+Extensions.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 06. 02..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import Combine

extension View {

    // Initial source: https://github.com/timdonnelly/DisplayLink
    func onFrame(isActive: Bool = true, displayLink: DisplayLink = .shared, _ action: @escaping (DisplayLink.Frame) -> Void) -> some View {
        let publisher = isActive ? displayLink.eraseToAnyPublisher() : Empty<DisplayLink.Frame, Never>().eraseToAnyPublisher()
        return SubscriptionView(content: self, publisher: publisher, action: action)
    }
}
