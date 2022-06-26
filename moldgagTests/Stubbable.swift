//
//  Stubbable.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

protocol Stubbable {
   
    static func stub() -> Self
    
}

extension Stubbable {
    
    func setting<T>(_ keyPath: WritableKeyPath<Self, T>, to value: T) -> Self {
        var stub = self
        stub[keyPath: keyPath] = value
        return stub
    }
}
