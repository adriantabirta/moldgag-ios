//
//  RealUserAuthoriationLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Resolver
import SwiftKeychainWrapper
import Foundation

class RealUserAuthoriationLocalDataSource {
    
    // MARK: - Propreties
    
    private let key = String(describing: UserAuthorizationLocalDataModel.self)
    
}

extension RealUserAuthoriationLocalDataSource: UserAuthoriationLocalDataSource {
    
    func existUser(withIdentityToken token: String) -> Bool {
        guard let data = getCurrentAuthorization() else { return false }
        return data.id == token
    }
    
    func save(_ userAuthorizationLocalDataModel: UserAuthorizationLocalDataModel) {
        KeychainWrapper.standard.set(try! JSONEncoder().encode(userAuthorizationLocalDataModel), forKey: key)
    }
    
    func getCurrentAuthorization() -> Optional<UserAuthorizationLocalDataModel> {
        guard let data = KeychainWrapper.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(UserAuthorizationLocalDataModel.self, from: data)
    }
    
}
