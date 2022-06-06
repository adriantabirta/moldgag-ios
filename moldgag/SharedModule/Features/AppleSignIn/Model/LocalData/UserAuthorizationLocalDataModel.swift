//
//  UserAuthorizationLocalDataModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

struct UserAuthorizationLocalDataModel: Codable {
    
    let id: String
    
    let email: Optional<String>
    
    let firstName: Optional<String>
    
    let lastName: Optional<String>
    
    let jwt: Optional<Data>

}
