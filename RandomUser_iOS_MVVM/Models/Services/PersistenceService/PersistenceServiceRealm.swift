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
class PersistenceServiceRealm: PersistenceServiceProtocol {
    
    private let realm: Realm
    
    init(realm: Realm? = nil) {
        if let realm = realm {
            self.realm = realm
        } else {
            self.realm = try! Realm()
        }
    }
    
    /// Store a `Persistable` struct into a database.
    func add<T: Persistable>(_ value: T) {
        do {
            try realm.write {
                realm.add(value.managedObject(), update: .all)
            }
        } catch {
            
        }
    }
    
    /// Store some `Persistable` structs into a database.
    func add<T : Sequence>(_ sequence: T) where T.Element: Persistable {
        do {
            try realm.write {
                for element in sequence {
                    realm.add(element.managedObject(), update: .all)
                }
            }
        } catch {
            
        }
    }
    
    /// Delete the `Object` Element from the database.
    func delete<Element: Object>(_ objects: Results<Element>) {
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            
        }
    }
    
    /// Retrieve the `Object` Element from the database.
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element> {
        return realm.objects(type)
    }
}
