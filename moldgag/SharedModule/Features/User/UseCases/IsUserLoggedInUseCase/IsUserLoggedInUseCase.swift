//
//  IsUserLoggedInUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Combine

protocol IsUserLoggedInUseCase {
    
    func execute() -> AnyPublisher<Bool, Never>
    
}


//UserSignInStatusRepository
