//
//  RealUserAuthorizationToUserAuthorizationRemoteDataModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

struct RealUserAuthorizationToUserAuthorizationRemoteDataModelMapper: UserAuthorizationToUserAuthorizationRemoteDataModelMapper {
    
    func map(from model: UserAuthorization) -> UserAuthorizationRemoteDataModel? {
        guard let jwt = model.identityToken else { return nil }
        return UserAuthorizationRemoteDataModel(userId: model.id, firstName: model.firstName,
                                         lastName: model.lastName, jwt: jwt)
    }
}
