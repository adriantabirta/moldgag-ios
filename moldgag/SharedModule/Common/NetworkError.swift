//
//  NetworkError.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

public enum NetworkError: Error {
    
    case unauthorized
    
    case fatal
    
    case unableToBuildRequest
    
    case raw(String)
    
    init(_ error: Error) {
        self = .raw(error.localizedDescription)
    }
}
