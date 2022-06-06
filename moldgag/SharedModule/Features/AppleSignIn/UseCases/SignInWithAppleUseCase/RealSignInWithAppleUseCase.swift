//
//  RealSignInWithAppleUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 31.05.2022.
//

import Combine
import Resolver
import AuthenticationServices

class RealSignInWithAppleUseCase: NSObject {
    
    // MARK: - Dependencies
    
    @Injected var userAuthorizationRepository: UserAuthorizationRepository
    
    @Injected var mapper: ASAuthorizationAppleIDCredentialToUserAuthorizationMapper
    
    // MARK: - Propreties
    
    private let provider = ASAuthorizationAppleIDProvider()
    
    private let passthroughSubject = PassthroughSubject<Void, ApplicationError>()
    
    private var window: UIWindow
    
    private var bag = Set<AnyCancellable>()
    
    init?(window: UIWindow?) {
        guard let window = window else { return nil }
        self.window = window
    }
}

// MARK: - Private

private extension RealSignInWithAppleUseCase {
    
    func performAuthorizationRequests() {
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - SignInWithAppleUseCase

extension RealSignInWithAppleUseCase: SignInWithAppleUseCase {
    
    func execute() -> AnyPublisher<Void, ApplicationError> {
        self.performAuthorizationRequests()
        return passthroughSubject.eraseToAnyPublisher()
    }
    
}

// MARK: - ASAuthorizationControllerDelegate

extension RealSignInWithAppleUseCase: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            userAuthorizationRepository.authorize(userAuthorization: mapper.map(from: credentials))
                .sink(receiveCompletion: { _ in}) { token in
                    // todo: save token for requests
                    self.passthroughSubject.send(Void())
                }.store(in: &bag)
            
        default: break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        passthroughSubject.send(completion: .failure(ApplicationError(error)))
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension RealSignInWithAppleUseCase: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return window
    }
}
