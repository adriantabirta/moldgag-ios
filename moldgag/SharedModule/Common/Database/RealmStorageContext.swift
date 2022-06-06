//
//  RealmStorageContext.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Foundation
import RealmSwift

/// RealmStorageContext  -  realm implementation for `StorageContext`.
public class RealmStorageContext: StorageContext {
    
    private lazy var configuration = Realm.Configuration(readOnly: false,
                                                         // Set the new schema version. This must be greater than the previously used
                                                         // version (if you've never set a schema version before, the version is 0).
                                                         schemaVersion: 1,
                                                         
                                                         // Set the block which will be called automatically when opening a Realm with
                                                         // a schema version lower than the one set above
                                                         migrationBlock: { migration, oldSchemaVersion in
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automatically
        }
    },
                                                         deleteRealmIfMigrationNeeded: true,
                                                         shouldCompactOnLaunch: { totalBytes, usedBytes in
        // totalBytes refers to the size of the file on disk in bytes (data + free space)
        // usedBytes refers to the number of bytes used by data in the file
        
        
        let maximumAllowedSpaceOnDisk: Int = 100 * 1024 * 1024
        
        return (totalBytes > maximumAllowedSpaceOnDisk) && (Double(usedBytes) / Double(totalBytes)) < 0.5
    })
    
    private lazy var realmQueue: DispatchQueue = DispatchQueue(label: "realm-queue.background", qos: .background)
    
    /// Init method
    ///
    /// - Parameter maximumAllowedSpaceOnDisk: Default 100mb. Compact if the file is over 100MB in size and less than 50% 'used'.
    public required init() throws {
        
        
        // todo: add aditional config here like:
        // migrations, default file to load data, etc.
    }
}

//MARK: - Realm write block
extension RealmStorageContext {
    
    public var queue: DispatchQueue {
        return realmQueue
    }
    
    /// Upsert - create or update method in save maner, does not matther from that thread object was created.
    public func upsertThreadSafeManer<T: RealmSwift.Object>(_ model: T) {
        realmQueue.async {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.add(model, update: Realm.UpdatePolicy.all)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    
    /// Write block required by Realm.
    public func safeWrite(_ block: (() throws -> Void)) throws {
        guard let realm = try? Realm() else {
            throw NSError()
        }
        
        if realm.isInWriteTransaction {
            try block()
        } else {
            try realm.write(block)
        }
    }
}

//MARK: - Realm create/update object
extension RealmStorageContext {
    
    public func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws {
        guard let realm = try? Realm() else {
            throw NSError()
        }
        
        try self.safeWrite {
            let newObject = realm.create(model as! Object.Type, value: [], update: Realm.UpdatePolicy.error) as! T
            completion(newObject)
        }
    }
    
    public func save(object: Storable, update: Bool = false) -> Storable? {
        
        //        let objectRef = ThreadSafeReference(to: object)
        //
        //        realmQueue.async {
        //            do {
        //                let realm = try Realm()
        //
        //                try realm.safeWrite {
        //
        //                    guard let unwrapped = objectRef else { return }
        //                    update ? realm.add(unwrapped, update: .all) : realm.add(unwrapped)
        //
        //                }
        //            } catch let error {
        //                print(error)
        //            }
        //        }
        
        
        //        guard let realm = try? Realm(configuration: configuration) else {
        //            throw NSError()
        //        }
        
        //        realmQueue.async {
        do {
            
            let realm = try Realm()
            
            try self.safeWrite {
                update ? realm.add(object as! Object, update: .all) : realm.add(object as! Object)
            }
            
            return object
            
        } catch let error {
            print(error)
            return nil
        }
        //        }
    }
    
    public func update(block: @escaping () -> Void) throws {
        try self.safeWrite {
            block()
        }
    }
}

//MARK: - Realm delete object/s
extension RealmStorageContext {
    
    public func delete(object: Storable) throws {
        guard let realm = try? Realm() else {
            throw NSError()
        }
        
        try self.safeWrite {
            realm.delete(object as! Object)
        }
    }
    
    public func deleteAll<T : Storable>(_ model: T.Type) throws {
        guard let realm = try? Realm() else {
            throw NSError()
        }
        
        try self.safeWrite {
            let objects = realm.objects(model as! Object.Type)
            
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    public func deleteAll(except types: Object.Type...) {
        realmQueue.async {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.configuration
                        .objectTypes?
                        .compactMap({ $0 as? Object.Type })
                        .forEach({ typeToDelete in
                            if !types.contains(where: { $0 == typeToDelete }) {
                                realm.delete(realm.objects(typeToDelete))
                            }
                        })
                }
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func reset() throws {
        guard let realm = try? Realm() else {
            throw NSError()
        }
        
        try self.safeWrite {
            realm.deleteAll()
        }
    }
}

//MARK: - Realm fetch object(s)
extension RealmStorageContext {
    
    public func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [T] where T : Storable {
        guard let realm = try? Realm() else { return [] }
        
        var objects = realm.objects(model as! Object.Type)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        var accumulate: [T] = [T]()
        for object in objects {
            accumulate.append(object as! T)
        }
        
        
        return accumulate
    }
    
    public func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> AnyPublisher<Array<T>, DatabaseError> {
        guard let realm = try? Realm() else { return Fail(error: DatabaseError.unableToInitialize).eraseToAnyPublisher() }
        return realm.objects(T.self as! Object.Type).collectionPublisher
            .mapError({ DatabaseError($0) })
            .map({ Array($0.map({ $0 as! T })) })
            .eraseToAnyPublisher()
    }
    
    public func findBy<T: Storable, KeyType>(_ model: T.Type, primaryKey: KeyType) -> Optional<T> {
        guard let realm = try? Realm() else { return nil }
        return realm.object(ofType: T.self as! Object.Type, forPrimaryKey: primaryKey) as? T
    }
    
    public func dropDatabase() {
        realmQueue.async {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.deleteAll()
                }
                
            } catch let error {
                print(error)
            }
        }
    }
}
