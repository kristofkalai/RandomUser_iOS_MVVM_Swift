//
//  UIScreen+Extensions.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import UIKit

/// UIScreen extension for the more convinient access.
extension UIScreen {
    static var width: CGFloat {
        UIScreen.main.bounds.width
    }

    static var height: CGFloat {
        UIScreen.main.bounds.height
    }
}
