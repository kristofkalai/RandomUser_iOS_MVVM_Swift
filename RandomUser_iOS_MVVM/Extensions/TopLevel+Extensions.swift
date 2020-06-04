//
//  TopLevel+Extensions.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 06. 04..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

/// Run something on the main thread asynchronously after a given delay
func run(_ delay: Double = 0.0, onCompletion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        onCompletion()
    }
}
