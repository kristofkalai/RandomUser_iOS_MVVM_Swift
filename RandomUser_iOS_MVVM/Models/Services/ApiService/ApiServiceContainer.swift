//
//  UserService.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 31..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

// MARK: - Store the network communication's data.
class ApiServiceContainer: ApiServiceContainerProtocol {
    
    /// The API URL (in `String` format).
    /// - Note:
    /// The number in the `String` indicate the used version of the API.
    /// With `1.3` it works fine, but maybe a newer version would break the implementation.
    static func getBaseApiUrl() -> String {
        return "https://randomuser.me/api/1.3/"
    }
}
