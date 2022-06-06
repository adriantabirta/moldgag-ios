//
//  StorageContext.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import RealmSwift
import Foundation

public protocol StorageContext {
    
    var queue: DispatchQueue { get }
    
    //MARK: - Create / update methods
    /// Create a new object with default values
    /// return an object that is conformed to the `Storable` protocol
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
    
    /// Upsert realm object in thread save maner
    func upsertThreadSafeManer<T: RealmSwift.Object>(_ model: T)
    
    /// Save an object that is conformed to the `Storable` protocol
    func save(object: Storable, update: Bool) -> Storable?
    
    /// Update an object that is conformed to the `Storable` protocol
    func update(block: @escaping () -> ()) throws
    
    
    //MARK: - Fetch methods
    /// Return a list of objects that are conformed to the `Storable` protocol
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [T]
    
    /// Combinee fetch method
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> AnyPublisher<Array<T>, DatabaseError>
    
    /// Find object by primaryKey that are conformed to the `Storable` protocol
    func findBy<T: Storable, KeyType>(_ model: T.Type, primaryKey: KeyType) -> Optional<T>
    
    
    //MARK: - Delete methods
    /// Delete an object that is conformed to the `Storable` protocol
    func delete(object: Storable) throws
    
    /// Delete all objects that are conformed to the `Storable` protocol
    func deleteAll<T: Storable>(_ model: T.Type) throws
    
    /// Delete all except specified types.
    func deleteAll(except types: Object.Type...)
    
    /// Delete all object and data from database.
    func dropDatabase()
    
}
