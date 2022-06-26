//
//  RealIsUserLoggedInUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Combine
import Resolver
import AuthenticationServices

class RealIsUserLoggedInUseCase {
    
    // MARK: - Dependencies
    
    @Injected var getUserUseCase: GetUserUseCase
    
    // MARK: - Propreties
    
    private let provider = ASAuthorizationAppleIDProvider()
    
    private let passthroughSubject = PassthroughSubject<Bool, Never>()
    
}

// MARK: - IsUserLoggedInUseCase

extension RealIsUserLoggedInUseCase: IsUserLoggedInUseCase {
    
    func execute() -> AnyPublisher<Bool, Never> {
        guard let user = getUserUseCase.execute() else { return Just(false).eraseToAnyPublisher() }
        
        provider.getCredentialState(forUserID: user.id) { state, error in
            
            if case .authorized = state {
                self.passthroughSubject.send(true)
            } else {
                self.passthroughSubject.send(false)
            }
        }
        
        return passthroughSubject.eraseToAnyPublisher()
    }
    
}


//switch state {
//case .authorized:
//    // Credentials are valid.
//    // update on backend?
//    self.passthroughSubject.send(true)
//    break
//
//case .revoked:
//    // Credential revoked, log them out
//    // clean keychain cache
//    // clean jwt token
//    // clean database
//    // clean cached videos & photos
//    break
//
//case .notFound:
//    // Credentials not found, show login UI
////                self.performAuthorizationRequests()
//    // save into keychain
//    // save jwt token
//    // move to main screen
//    break
//
//case .transferred:
//    // The app has been transferred to a different team, and you need to migrate the user’s identifier.
//    // maybe error?
//    break
//
//@unknown default:
//    break
//}
