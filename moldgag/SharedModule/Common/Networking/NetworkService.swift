//
//  NetworkService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Foundation

typealias UploadFileParameters = Array<Dictionary<String, Any>>

protocol NetworkService {
    
    var baseUrl: String { get }
    
    var path: String { get }
    
    var headers: Dictionary<String, String> { get }
    
    var method: HTTPMethod { get }
    
    var bodyParameters: Optional<UploadFileParameters> { get }

    var body: Optional<Data> { get }
    
    var urlRequest: Optional<URLRequest> { get }
    
}
