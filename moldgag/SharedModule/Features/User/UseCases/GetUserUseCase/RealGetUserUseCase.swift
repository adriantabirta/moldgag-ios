//
//  RealGetUserUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Resolver

class RealGetUserUseCase {
    
    // MARK: - Depencencies
    
    @Injected var userRepository: UserRepository
    
}

// MARK: - GetUserUseCase

extension RealGetUserUseCase: GetUserUseCase {
    
    func execute() -> Optional<User> {
        userRepository.getCurrentUser()
    }
}
