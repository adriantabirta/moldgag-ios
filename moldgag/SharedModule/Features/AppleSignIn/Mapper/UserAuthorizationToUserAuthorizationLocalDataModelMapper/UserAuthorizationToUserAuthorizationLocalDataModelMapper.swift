//
//  UserAuthorizationToUserAuthorizationLocalDataModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

protocol UserAuthorizationToUserAuthorizationLocalDataModelMapper {
    
    func map(from model: UserAuthorization) -> UserAuthorizationLocalDataModel
    
}
