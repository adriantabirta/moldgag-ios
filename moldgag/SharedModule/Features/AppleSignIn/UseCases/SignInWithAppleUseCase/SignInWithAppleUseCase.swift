//
//  SignInWithAppleUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 31.05.2022.
//

import Combine

protocol SignInWithAppleUseCase {
    
    func execute() -> AnyPublisher<Void, ApplicationError>
    
}
