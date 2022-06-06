//
//  GetUserUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

protocol GetUserUseCase {
    
    func execute() -> Optional<User>
    
}
