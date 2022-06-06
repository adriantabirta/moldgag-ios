//
//  UserAuthoriationLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

protocol UserAuthoriationLocalDataSource {
    
    func existUser(withIdentityToken token: String) -> Bool
    
    func save(_ userAuthorizationLocalDataModel: UserAuthorizationLocalDataModel)
    
    func getCurrentAuthorization() -> Optional<UserAuthorizationLocalDataModel>
    
}
