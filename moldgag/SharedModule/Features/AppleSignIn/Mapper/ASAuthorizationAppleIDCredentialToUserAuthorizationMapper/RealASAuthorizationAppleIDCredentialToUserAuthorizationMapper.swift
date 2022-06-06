//
//  RealASAuthorizationAppleIDCredentialToUserAuthorizationMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 31.05.2022.
//

import AuthenticationServices

struct RealASAuthorizationAppleIDCredentialToUserAuthorizationMapper: ASAuthorizationAppleIDCredentialToUserAuthorizationMapper {
    
    func map(from model: ASAuthorizationAppleIDCredential) -> UserAuthorization {
        UserAuthorization(id: model.user, firstName: model.fullName?.givenName,
                          lastName: model.fullName?.familyName, email: model.email, identityToken: model.identityToken)
    }
}
