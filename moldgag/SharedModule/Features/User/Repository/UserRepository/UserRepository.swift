//
//  UserRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

protocol UserRepository {
    
    func getCurrentUser() -> Optional<User>
    
}
