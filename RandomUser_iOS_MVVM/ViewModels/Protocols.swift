//
//  Protocols.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 19..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

// MVVM architecture presents a one-direct data flow, so
// - View contains ViewModel,
// - ViewModel contains Model,
// and no other containment or any other communication are not allowed

// MARK: - ViewModel needs to implement this.
protocol RandomUserViewModelProtocol {
    
    /// The so far fetched user data.
    var users: [User] { get set }
    
    /// Whether the refresh spinner should shown or not.
    var showRefreshView: Bool { get set }
    
    /// Returns the so far fetched data + number of users in a page.
    var currentMaxUsers: Int { get }
    
    /// Fetch some random users.
    func getRandomUsers(refresh: Bool)
}

// MARK: - Service needs to implement this.
protocol RandomUserServiceProtocol {
    
    /// Download random users with the given parameters.
    /// - Parameters:
    ///   - page: the page that you want to download.
    ///   - results: the number of results in a page.
    ///   - seed: the API use this to give some data. For the same seed, it gives back the same results.
    ///   - completion: will be called after the data is ready in an array, or some error occured. Both parameters in the same time couldn't be `nil`.
    func getUsers(page: Int, results: Int, seed: String, completion: @escaping ([User]?, String?) -> ())
}

extension RandomUserServiceProtocol {
    
    /// The API URL (in `String`).
    /// - Note:
    /// The number in the `String` indicate the used version of the API.
    /// With `1.3` it works fine, but maybe a newer version would break the implementation.
    func getBaseApiUrl() -> String {
        return "https://randomuser.me/api/1.3/"
    }
}

