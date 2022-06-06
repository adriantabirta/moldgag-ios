//
//  UserAuthorizationToUserAuthorizationRemoteDataModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

protocol UserAuthorizationToUserAuthorizationRemoteDataModelMapper {
    
    func map(from model: UserAuthorization) -> UserAuthorizationRemoteDataModel?

}
