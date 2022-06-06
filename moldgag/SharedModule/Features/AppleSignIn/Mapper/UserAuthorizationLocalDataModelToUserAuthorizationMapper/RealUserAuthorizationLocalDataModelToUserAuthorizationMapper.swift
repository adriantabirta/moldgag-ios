//
//  RealUserAuthorizationLocalDataModelToUserAuthorizationMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

struct RealUserAuthorizationLocalDataModelToUserAuthorizationMapper: UserAuthorizationLocalDataModelToUserAuthorizationMapper {
    
    func map(from model: UserAuthorizationLocalDataModel) -> UserAuthorization {
        UserAuthorization(id: model.id, firstName: model.firstName, lastName: model.lastName, email: model.email, identityToken: model.jwt)
    }
}
