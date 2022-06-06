//
//  RealUserAuthorizationToUserMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

struct RealUserAuthorizationToUserMapper: UserAuthorizationToUserMapper {
    
    func map(from model: UserAuthorization) -> User {
        User(id: model.id)
    }
    
}
