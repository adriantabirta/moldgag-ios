//
//  ApplicationError.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Foundation

public enum ApplicationError: Error {
    
    case network(NetworkError)
    
    case database(DatabaseError)
    
    case decoding
    
    case custom(String)
    
    case unknownError
    
    init(_ error: Error) {
        self = .unknownError
    }
    
    init (_ value: String) {
        self = .custom(value)
    }
    
    func handle()  {
        print("ApplicationError - \(self.description)")
    }
}

extension ApplicationError: CustomStringConvertible {
    
    public var description: String {
        return String(self.localizedDescription)
    }
}
