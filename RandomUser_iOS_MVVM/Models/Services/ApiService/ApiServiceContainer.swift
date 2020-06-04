//
//  UserService.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 31..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

// MARK: - Manages the app's network communications.
class ApiServiceContainer {
    
    /// Supports the 2 major HTTP communication external libraries.
    enum USType {
        case alamofire
        case moya
    }
    
    let service: ApiServiceProtocol
    
    init(_ usType: USType = .alamofire) {
        switch usType {
        case .alamofire:
            service = ApiServiceAlamofire()
        case .moya:
            service = ApiServiceAlamofire()
        }
    }
}

// MARK: - Implement the delegate pattern.
/// Delegate all of the `ApiServiceContainerProtocol` methods to the `service` property.
extension ApiServiceContainer: ApiServiceContainerProtocol {
    
    /// The API URL (in `String` format).
    /// - Note:
    /// The number in the `String` indicate the used version of the API.
    /// With `1.3` it works fine, but maybe a newer version would break the implementation.
    static func getBaseApiUrl() -> String {
        return "https://randomuser.me/api/1.3/"
    }
}
