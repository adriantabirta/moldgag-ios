//
//  DatabaseError.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

public enum DatabaseError: Error {
    
    case unableToInitialize
    
    case unableToStore
    
    case needMigration
    
    init(_ error: Error) {
        self = .needMigration
    }
    
}
