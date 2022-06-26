//
//  DatabaseError.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

public enum DatabaseError: Error {
    
    case unableToRead(String)
    
    case unableToWrite(String)
        
}
