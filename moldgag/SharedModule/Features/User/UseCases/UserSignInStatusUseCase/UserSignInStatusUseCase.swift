//
//  UserSignInStatusUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Combine

protocol UserSignInStatusUseCase {
    
    func isUserSignedIn() -> AnyPublisher<Bool, Never>
    
}


//UserSignInStatusRepository
