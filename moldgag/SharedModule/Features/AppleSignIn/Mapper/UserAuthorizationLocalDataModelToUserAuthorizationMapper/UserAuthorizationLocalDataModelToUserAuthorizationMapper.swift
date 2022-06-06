//
//  UserAuthorizationLocalDataModelToUserAuthorizationMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

protocol UserAuthorizationLocalDataModelToUserAuthorizationMapper {
    
    func map(from model: UserAuthorizationLocalDataModel) -> UserAuthorization
    
}
