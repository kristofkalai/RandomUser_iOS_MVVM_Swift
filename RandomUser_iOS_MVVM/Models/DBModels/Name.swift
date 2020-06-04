//
//  Name.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation
import RealmSwift

struct Name: Codable {
    let first: String
    let last: String
    let title: String
}

final class NameObject: Object {
    
    @objc dynamic var identifier = UUID().uuidString
    @objc dynamic var first = ""
    @objc dynamic var last = ""
    @objc dynamic var title = ""
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
}

extension Name: Persistable {
    
    /// Create the `struct` based on the `Object` from the database.
    /// If the`Object` is `nil`, it should initialize the struct appropriately.
    init(managedObject: NameObject? = nil) {
        if let managedObject = managedObject {
            first = managedObject.first
            last = managedObject.last
            title = managedObject.title
        } else {
            first = ""
            last = ""
            title = ""
        }
    }
    
    /// Create the `Object` that will be stored in the database based on the `struct`.
    func managedObject() -> NameObject {
        let name = NameObject()
        name.first = first
        name.last = last
        name.title = title
        return name
    }
}
