//
//  UserAuthorizationRemoteDataModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

struct UserAuthorizationRemoteDataModel {
    
    let userId: String
    
    let firstName: Optional<String>
    
    let lastName: Optional<String>
        
    let jwt: Data
    
}
