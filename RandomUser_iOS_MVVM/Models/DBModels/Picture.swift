//
//  Picture.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

struct Picture: Codable {
    
    /// It doesn't store the thumbnail picture (because I don't use it), since it's too small for even the `UITableView`.
    
    let large: String
    let medium: String
}
