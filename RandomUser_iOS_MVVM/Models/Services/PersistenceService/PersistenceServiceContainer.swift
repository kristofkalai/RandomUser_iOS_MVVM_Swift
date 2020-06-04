//
//  PersistenceServiceContainer.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 31..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import RealmSwift

// MARK: - Manages the app's persistence.
class PersistenceServiceContainer {
    
    /// Supports the 1 major external library.
    enum PSType {
        case realm
    }
    
    let service: PersistenceServiceProtocol
    
    init(_ psType: PSType = .realm) {
        switch psType {
        case .realm:
            service = PersistenceServiceRealm()
        }
    }
}
