//
//  User.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation
import RealmSwift

struct User: Codable, Identifiable {
    let id = UUID()

    let name: Name
    let picture: Picture
    let gender: String
    let email: String
    let phone: String
    let cell: String
    let location: Location

    private enum CodingKeys: String, CodingKey {
        case name, picture, gender, email, phone, cell, location
    }

    /// Returns the full name (firstly the first name and then the last).
    var fullName: String {
        "\(name.title) \(name.first) \(name.last)"
    }

    /// Returns the ways the user can be reached in a formatted `String`.
    var accessibilities: String {
        "Contacts:\n\tEmail: \(email)\n\tCellphone: \(cell)\n\tPhone: \(phone)"
    }

    /// Returns the location of the user in a formatted `String`.
    var expandedLocation: String {
        "Address:\n\t\(location.country), \(location.state), \(location.city)\n\tStreet \(location.street.name) \(location.street.number)"
    }
}

final class UserObject: Object {
    @objc dynamic var identifier = UUID().uuidString
    @objc dynamic var name: NameObject? = .init()
    @objc dynamic var picture: PictureObject? = .init()
    @objc dynamic var gender = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var cell = ""
    @objc dynamic var location: LocationObject? = .init()

    override static func primaryKey() -> String? {
        "identifier"
    }
}

extension User: Persistable {
    /// Create the `struct` based on the `Object` from the database.
    /// If the`Object` is `nil`, it should initialize the struct appropriately.
    init(managedObject: UserObject? = nil) {
        if let managedObject {
            gender = managedObject.gender
            email = managedObject.email
            phone = managedObject.phone
            cell = managedObject.cell
            location = Location(managedObject: managedObject.location)
            name = Name(managedObject: managedObject.name)
            picture = Picture(managedObject: managedObject.picture)
        } else {
            gender = ""
            email = ""
            phone = ""
            cell = ""
            location = Location()
            name = Name()
            picture = Picture()
        }
    }

    /// Create the `Object` that will be stored in the database based on the `struct`.
    func managedObject() -> UserObject {
        let user = UserObject()
        user.name = name.managedObject()
        user.picture = picture.managedObject()
        user.gender = gender
        user.email = email
        user.phone = phone
        user.cell = cell
        user.location = location.managedObject()
        return user
    }
}
