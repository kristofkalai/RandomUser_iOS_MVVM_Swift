//
//  ApiServiceProtocols.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 06. 01..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

// MARK: - ApiService Container part.
protocol ApiServiceContainerProtocol {
    
    /// The API URL (in `String` format).
    static func getBaseApiUrl() -> String
}

// MARK: - ApiService part.
protocol ApiServiceProtocol {
    
    /// Download random users with the given parameters.
    /// - Parameters:
    ///   - page: the page that wanted to be downloaded.
    ///   - results: the number of results in a page.
    ///   - seed: the API use this to give back some data. For the same seed it gives back the same results.
    ///   - completion: will be called after the data is ready in an array, or an error occured. Both parameters in the same time couldn't be `nil`.
    func getUsers(page: Int, results: Int, seed: String, completion: @escaping (Result<[User], ErrorTypes>) -> ())
}
