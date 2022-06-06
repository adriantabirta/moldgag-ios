//
//  UserAuthorization.swift
//  moldgag
//
//  Created by Adrian Tabirta on 31.05.2022.
//

import Foundation

struct UserAuthorization: Equatable {
    
    let id: String
    
    let firstName: Optional<String>
    
    let lastName: Optional<String>
    
    let email: Optional<String>
    
    let identityToken: Data?
    
}
