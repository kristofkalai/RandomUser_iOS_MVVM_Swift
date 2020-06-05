//
//  RandomUsersViewModel.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

/// The main ViewModel part.
/// It contains the data, the "business logic."
class RandomUsersViewModel: ObservableObject {
    
    /// Will be fired if `users` changed.
    var objectWillChange = PassthroughSubject<Array<User>, Never>()
    
    /// Whether the refresh spinner should shown or not.
    @Published var showRefreshView: Bool = false
    
    /// The so far fetched user data.
    var users = [User]()
    
    /// Returns the so far fetched data + number of users in a page.
    var currentMaxUsers: Int {
        return nextPage * numberOfUsersPerPage
    }
    
    private var numberOfUsersPerPage = 10
    private var seed = UUID().uuidString
    private var nextPage: Int {
        return users.count / numberOfUsersPerPage + 1
    }
    private var apiService: ApiServiceProtocol
    private var persistenceService: PersistenceServiceProtocol
    
    /// Dependency Injection via Constructor Injection.
    init(_ persistenceServiceType: PersistenceServiceContainer.PSType = .realm) {
        apiService = AppDelegate.container.resolve(ApiServiceProtocol.self)!
        self.persistenceService = PersistenceServiceContainer.init(persistenceServiceType).service
        getCachedUsers()
    }
}

// MARK: - RandomUserViewModelProtocol part.
extension RandomUsersViewModel: RandomUserViewModelProtocol {
    
    /// Fetch some random users.
    func getRandomUsers(refresh: Bool = false) {
        
        if refresh {
            users.removeAll()
            seed = UUID().uuidString
        } else {
            guard showRefreshView == false else { return }
        }
        
        showRefreshView = true
        
        apiService.getUsers(page: nextPage, results: numberOfUsersPerPage, seed: seed) { [weak self] result in
            guard let self = self else { return }
            self.showRefreshView = false
            switch result {
            case .success(let users):
                self.clearNilsFromArray()
                self.users.append(contentsOf: users)
                if self.users.count > self.numberOfUsersPerPage {
                    self.persistenceService.deleteAndAdd(UserObject.self, self.users)
                }
                self.addNilsToArray()
                
                self.objectWillChange.send(self.users)
            case .failure(_):
                break
            }
        }
    }
}

extension RandomUsersViewModel {
    
    /// After fetching, the array needs to be cleared from the "nil users".
    private func clearNilsFromArray() {
        users = users.filter { user -> Bool in
            user.email != ""
        }
    }
    
    /// After fetching and storing, the array needs to be filled with "nil users".
    /// By default the last 10 elements will be "nil users".
    private func addNilsToArray(_ nums: Int = 10) {
        for _ in 0 ..< nums {
            users.append(User())
        }
    }
    
    /// Retrieve the cached users (if available, else it downloads some from the internet).
    private func getCachedUsers() {
        let users = self.persistenceService.objects(UserObject.self)
        for user in users {
            self.users.append(User(managedObject: user))
        }
        if self.users.count == 0 {
            getRandomUsers()
        } else {
            addNilsToArray()
        }
    }
}
