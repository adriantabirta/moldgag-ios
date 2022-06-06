//
//  RealGetUserUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Resolver

class RealGetUserUseCase: GetUserUseCase {
    
    // MARK: - Depencencies
    
    @Injected var userRepository: UserRepository
    
    func execute() -> Optional<User> {
        userRepository.getCurrentUser()
    }
}
