//
//  AuthorizationNetworkService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 01.06.2022.
//

import Foundation

enum AuthorizationNetworkService: NetworkService {
    
    case authorize(_ userAuthorizationRemoteDataModel: UserAuthorizationRemoteDataModel)
    
}

// MARK: - NetworkService

extension AuthorizationNetworkService {
    
    var baseUrl: String {
        ""
    }
    
    var path: String {
        return ""
    }
    
    var headers: Dictionary<String, String> {
        [:]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var bodyParameters: Optional<UploadFileParameters> {
        nil
    }
    
    var body: Optional<Data> {
        nil
    }
    
    var urlRequest: Optional<URLRequest> {
        nil
    }
}
