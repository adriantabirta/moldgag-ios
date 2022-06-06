//
//  RealUserAuthorizationRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Combine
import Resolver
import AuthenticationServices

// todo: store our service jwt into another repository
class RealUserAuthorizationRepository {
    
    // MARK: - Dependencies
    
    @Injected var userAuthoriationLocalDataSource: UserAuthoriationLocalDataSource
    
    @Injected var userAuthoriationRemoteDataSource: UserAuthoriationRemoteDataSource
    
    @Injected var userAuthorizationToUserAuthorizationLocalDataModelMapper: UserAuthorizationToUserAuthorizationLocalDataModelMapper
    
    @Injected var userAuthorizationToUserAuthorizationRemoteDataModelMapper: UserAuthorizationToUserAuthorizationRemoteDataModelMapper
    
    @Injected var userAuthorizationLocalDataModelToUserAuthorizationMapper: UserAuthorizationLocalDataModelToUserAuthorizationMapper

    
}

// MARK: - UserAuthorizationRepository

extension RealUserAuthorizationRepository: UserAuthorizationRepository {
    
    func authorize(userAuthorization: UserAuthorization) -> AnyPublisher<JWTToken, ApplicationError> {
        
        
        if !userAuthoriationLocalDataSource.existUser(withIdentityToken: userAuthorization.id) {
            
            // save
            let userAuthorizationLocalDataModel = userAuthorizationToUserAuthorizationLocalDataModelMapper.map(from: userAuthorization)
            userAuthoriationLocalDataSource.save(userAuthorizationLocalDataModel)
            //
        }
        
        guard let userAuthorizationRemoteDataModel = userAuthorizationToUserAuthorizationRemoteDataModelMapper.map(from: userAuthorization) else {
            return Fail(error: ApplicationError("Unable to find jwt token")).eraseToAnyPublisher()
        }
        
        //        return userAuthoriationRemoteDataSource.authorize(userAuthorizationRemoteDataModel)
        //            .mapError({ ApplicationError($0) })
        //            .eraseToAnyPublisher()
        
        return Just("token").setFailureType(to: ApplicationError.self).eraseToAnyPublisher()
    }
    
    
    func getAuthorizedUser() -> Optional<UserAuthorization> {
        userAuthoriationLocalDataSource.getCurrentAuthorization()
            .map({ userAuthorizationLocalDataModelToUserAuthorizationMapper.map(from: $0) })
    }
    
}


