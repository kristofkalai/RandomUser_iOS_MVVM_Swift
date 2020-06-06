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
    
    /// Creates an `URL` with the given query parameters.
    /// - Note:
    /// The `URL` stores that too, that which data will be requested.
    /// The result of this method request from the API the `name`, `picture`, `gender`, `location`, `email`, `phone` and `cell`.
    static func createUrl(_ page: Int, _ results: Int, _ seed: String) -> URL? {
        let queryItems = [URLQueryItem(name: "inc", value: "name,picture,gender,location,email,phone,cell"),
                          URLQueryItem(name: "page", value: String(page)),
                          URLQueryItem(name: "results", value: String(results)),
                          URLQueryItem(name: "seed", value: String(seed))]
        guard var urlComps = URLComponents(string: ApiServiceContainer.getBaseApiUrl()) else { return nil }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return nil }
        return url
    }
}
