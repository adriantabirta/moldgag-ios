//
//  RealUserAuthorizationToUserAuthorizationLocalDataModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

struct RealUserAuthorizationToUserAuthorizationLocalDataModelMapper: UserAuthorizationToUserAuthorizationLocalDataModelMapper {
    
    func map(from model: UserAuthorization) -> UserAuthorizationLocalDataModel {
        UserAuthorizationLocalDataModel(id: model.id, email: model.email, firstName: model.firstName,
                                        lastName: model.lastName, jwt: model.identityToken)
    }
}
