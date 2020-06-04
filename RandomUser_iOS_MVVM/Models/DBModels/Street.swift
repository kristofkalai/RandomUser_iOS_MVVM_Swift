//
//  Street.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation
import RealmSwift

struct Street: Codable {
    let name: String
    let number: Int
}

final class StreetObject: Object {
    
    @objc dynamic var identifier = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var number = 0
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
}

extension Street: Persistable {
    
    /// Create the `struct` based on the `Object` from the database.
    /// If the`Object` is `nil`, it should initialize the struct appropriately.
    init(managedObject: StreetObject? = nil) {
        if let managedObject = managedObject {
            name = managedObject.name
            number = managedObject.number
        } else {
            name = ""
            number = 0
        }
    }
    
    /// Create the `Object` that will be stored in the database based on the `struct`.
    func managedObject() -> StreetObject {
        let street = StreetObject()
        street.name = name
        street.number = number
        return street
    }
}
