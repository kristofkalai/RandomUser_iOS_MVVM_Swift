//
//  PersistenceServiceRealm.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 31..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation
import RealmSwift

/// The `PersistenceServiceProtocol` implemented by Realm.
final class PersistenceServiceRealm {
    private let realm: Realm

    init(realm: Realm? = nil) {
        if let realm = realm {
            self.realm = realm
        } else {
            self.realm = try! Realm()
        }
    }
}

// MARK: - PersistenceServiceProtocol

extension PersistenceServiceRealm: PersistenceServiceProtocol {
    /// Store a `Persistable` struct into a database.
    func add<T: Persistable>(_ value: T) {
        try? realm.write {
            realm.add(value.managedObject(), update: .all)
        }
    }

    /// Store some `Persistable` structs into a database.
    func add<T : Sequence>(_ sequence: T) where T.Element: Persistable {
        try? realm.write {
            sequence.forEach {
                realm.add($0.managedObject(), update: .all)
            }
        }
    }

    /// Delete the `Object` Element from the database.
    func delete<Element: Object>(_ objects: Results<Element>) {
        try? realm.write {
            realm.delete(objects)
        }
    }

    /// Retrieve the `Object` Element from the database.
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element> {
        realm.objects(type)
    }
}
