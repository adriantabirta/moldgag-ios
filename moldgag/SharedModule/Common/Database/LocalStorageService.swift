//
//  LocalStorageService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import Foundation

let infinityValidity: Double = .infinity

public protocol LocalStorageService {
    
    func save(data: Data, key: String, validity numberOfSeconds: Double)
    
    func save<T: Encodable>(_ value: T, key: String, validity numberOfSeconds: Double)
    
    func get(key: String) -> Data?
    
    func get<T: Decodable>(_ type: T.Type, key: String) -> T?
    
    func remove(key: String)
    
    func isDataValid(key: String) -> Bool
    
    func updateDataValidity(key: String, validity numberOfSeconds: Double)
    
    func clearStorage()
}

extension LocalStorageService {
    
    func save(data: Data, key: String) {
        save(data: data, key: key, validity: infinityValidity)
    }
    
    func save<T: Encodable>(_ value: T, key: String) {
        save(value, key: key, validity: infinityValidity)
    }
}
