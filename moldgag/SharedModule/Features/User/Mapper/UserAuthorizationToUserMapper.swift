//
//  UserAuthorizationToUserMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

protocol UserAuthorizationToUserMapper {
    
    func map(from model: UserAuthorization) -> User
    
}
