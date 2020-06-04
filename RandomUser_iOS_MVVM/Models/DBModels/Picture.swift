//
//  Picture.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation
import RealmSwift

struct Picture: Codable {
    
    /// It doesn't store the thumbnail picture (because I don't use it), since it's too small for even the `UITableView`.
    
    let large: String
    let medium: String
}

final class PictureObject: Object {
    
    @objc dynamic var identifier = UUID().uuidString
    @objc dynamic var large = ""
    @objc dynamic var medium = ""
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
}

extension Picture: Persistable {
    
    /// Create the `struct` based on the `Object` from the database.
    /// If the`Object` is `nil`, it should initialize the struct appropriately.
    init(managedObject: PictureObject? = nil) {
        if let managedObject = managedObject {
            large = managedObject.large
            medium = managedObject.medium
        } else {
            large = ""
            medium = ""
        }
    }
    
    /// Create the `Object` that will be stored in the database based on the `struct`.
    func managedObject() -> PictureObject {
        let picture = PictureObject()
        picture.large = large
        picture.medium = medium
        return picture
    }
}
