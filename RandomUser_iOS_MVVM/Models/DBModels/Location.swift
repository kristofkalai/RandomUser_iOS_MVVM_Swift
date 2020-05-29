//
//  Location.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

struct Location: Codable {
    let city: String
    let country: String
    let state: String
    let street: Street
}
