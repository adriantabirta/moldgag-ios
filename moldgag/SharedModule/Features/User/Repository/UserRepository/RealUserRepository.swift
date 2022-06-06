//
//  RealUserRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Resolver

class RealUserRepository {
    
    // MARK: - Dependencies
    
    @Injected var userAuthorizationRepository: UserAuthorizationRepository
    
    @Injected var userAuthorizationToUserMapper: UserAuthorizationToUserMapper
    
}

extension RealUserRepository: UserRepository {
    
    func getCurrentUser() -> Optional<User> {
        userAuthorizationRepository.getAuthorizedUser().map { userAuthorizationToUserMapper.map(from: $0) }
    }
    
}
