//
//  UserAuthoriationRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Combine

protocol UserAuthoriationRemoteDataSource {
    
    func authorize(_ userAuthorizationRemoteDataModel: UserAuthorizationRemoteDataModel) -> AnyPublisher<String, NetworkError>
    
}
