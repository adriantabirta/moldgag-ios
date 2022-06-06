//
//  SignInViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.05.2022.
//

import Combine
import Resolver
import Foundation
import AuthenticationServices

class SignInViewModel {
    
    // MARK: - Dependencies
    
    @Injected var signInWithAppleUseCase: SignInWithAppleUseCase
    
    private var bag = Set<AnyCancellable>()
    
    @objc func signIn() {
        
        signInWithAppleUseCase.execute().sink(receiveCompletion: { _ in
            print("sign in fail")
            
        }) { _ in
            print("sign in success")
            
            let vc = VerticalScrollablePageView()
            let root = RootNavigationController(rootViewController: vc)
            
            
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window
            window?.rootViewController = root
            window?.makeKeyAndVisible()
            
            UIView.transition(with: window!, duration: 0.3,
                              options: .transitionCrossDissolve, animations: nil, completion: nil)
            
        }.store(in: &bag)
        
        
    }
}
