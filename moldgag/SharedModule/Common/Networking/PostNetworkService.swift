//
//  PostNetworkService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Foundation

enum PostNetworkService: NetworkService {

    case posts(page: Int)
    
    case create(title: String, url: String, postType: PostType)
    
}

// MARK: - NetworkService

extension PostNetworkService {
    
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
