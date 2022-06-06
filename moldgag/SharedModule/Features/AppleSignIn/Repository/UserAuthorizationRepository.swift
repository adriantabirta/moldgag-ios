//
//  UserAuthorizationRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Combine

typealias JWTToken = String

protocol UserAuthorizationRepository {
    
    func authorize(userAuthorization: UserAuthorization) -> AnyPublisher<JWTToken, ApplicationError>
    
    func getAuthorizedUser() -> Optional<UserAuthorization>
    
}
