//
//  PersistenceServiceProtocols.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 06. 01..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import RealmSwift

// MARK: - PersistenceService part.
protocol PersistenceServiceProtocol {
    
    /// Store a `Persistable` struct into a database.
    func add<T: Persistable>(_ value: T)
    
    /// Store some `Persistable` structs into a database.
    func add<T: Sequence>(_ sequence: T) where T.Element: Persistable
    
    /// Delete the `Object` Element from the database.
    func delete<Element: Object>(_ objects: Results<Element>)
    
    /// Retrieve the `Object` Element from the database.
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element>
}

extension PersistenceServiceProtocol {
    
    /// Delete the `Object` Element from the database and `Persistable` structs into a database.
    func deleteAndAdd<Element: Object, T: Sequence>(_ type: Element.Type, _ sequence: T) where T.Element: Persistable {
        delete(objects(type))
        add(sequence)
    }
}

// MARK: - Persistable part.
protocol Persistable {
    associatedtype ManagedObject: Object
    
    /// Create the `struct` based on the `Object` from the database.
    /// If the`Object` is `nil`, it should initialize the struct appropriately.
    init(managedObject: ManagedObject?)
    
    /// Create the `Object` that will be stored in the database based on the `struct`.
    func managedObject() -> ManagedObject
}
