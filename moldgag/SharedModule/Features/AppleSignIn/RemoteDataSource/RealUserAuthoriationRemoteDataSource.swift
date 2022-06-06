//
//  RealUserAuthoriationRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Combine
import Resolver

class RealUserAuthoriationRemoteDataSource {
    
    // MARK: - Dependencies
    
    @Injected var networkServiceProvider: NetworkServiceProvider<AuthorizationNetworkService>
    
}

// MARK: - UserAuthoriationRemoteDataSource

extension RealUserAuthoriationRemoteDataSource: UserAuthoriationRemoteDataSource {
    
    func authorize(_ userAuthorizationRemoteDataModel: UserAuthorizationRemoteDataModel) -> AnyPublisher<String, NetworkError> {
        networkServiceProvider.request(enpoint: .authorize(userAuthorizationRemoteDataModel)).eraseToAnyPublisher()
    }
}
