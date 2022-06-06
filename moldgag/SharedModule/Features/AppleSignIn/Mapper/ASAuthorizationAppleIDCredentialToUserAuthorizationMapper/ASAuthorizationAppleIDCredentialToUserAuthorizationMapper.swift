//
//  ASAuthorizationAppleIDCredentialToUserAuthorizationMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 31.05.2022.
//

import AuthenticationServices

protocol ASAuthorizationAppleIDCredentialToUserAuthorizationMapper {
    
    func map(from model: ASAuthorizationAppleIDCredential) -> UserAuthorization
    
}
