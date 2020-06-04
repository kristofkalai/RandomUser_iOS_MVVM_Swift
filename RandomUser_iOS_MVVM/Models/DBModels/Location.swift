//
//  Location.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation
import RealmSwift

struct Location: Codable {
    let city: String
    let country: String
    let state: String
    let street: Street
}

final class LocationObject: Object {
    
    @objc dynamic var identifier = UUID().uuidString
    @objc dynamic var city = ""
    @objc dynamic var country = ""
    @objc dynamic var state = ""
    @objc dynamic var street: StreetObject? = StreetObject()
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
}

extension Location: Persistable {
    
    /// Create the `struct` based on the `Object` from the database.
    /// If the`Object` is `nil`, it should initialize the struct appropriately.
    init(managedObject: LocationObject? = nil) {
        if let managedObject = managedObject {
            city = managedObject.city
            country = managedObject.country
            state = managedObject.state
            street = Street(managedObject: managedObject.street)
        } else {
            city = ""
            country = ""
            state = ""
            street = Street()
        }
    }
    
    /// Create the `Object` that will be stored in the database based on the `struct`.
    func managedObject() -> LocationObject {
        let location = LocationObject()
        location.city = city
        location.country = country
        location.state = state
        location.street = street.managedObject()
        return location
    }
}
