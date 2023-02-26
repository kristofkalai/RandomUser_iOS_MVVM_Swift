//
//  Protocols.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 19..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

// MVVM architecture presents a one-direct data flow, so
// - View contains ViewModel,
// - ViewModel contains Model,
// and other containment or any other communication are not allowed

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
