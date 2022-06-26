//
//  AuthenticationViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.05.2022.
//

import Combine
import Resolver
import Foundation
import AuthenticationServices

class AuthenticationViewModel {
    
    // MARK: - Dependencies
    
    @Injected var signInWithAppleUseCase: SignInWithAppleUseCase
    
    // MARK: - Propreties

    weak var coordinator: AuthenticationCoordinator?
    
    private var bag = Set<AnyCancellable>()
    
    @objc func signIn() {
        signInWithAppleUseCase.execute().sink(receiveCompletion: { _ in
            print("sign in fail")
            
        }) { _ in
            print("sign in success")
            self.coordinator?.navigateToMain()
        }.store(in: &bag) 
    }
}
