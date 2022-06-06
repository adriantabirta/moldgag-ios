//
//  UploadContentNetworkService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 02.06.2022.
//

import Foundation
import UIKit

enum UploadContentNetworkService: NetworkService {
    
    case upload(localUrl: URL, type: PostType, boundary: String = "Boundary-\(UUID().uuidString)")
    
}

// MARK: - NetworkService

extension UploadContentNetworkService {
    
    var baseUrl: String {
        "https://api.imgur.com"
    }
    
    var path: String {
        return "/3/upload"
    }
    
    var headers: Dictionary<String, String> {
        switch self {
        case let .upload(_, _, boundary):
            return [
                "Authorization": "Bearer 130c5cb37b1089e0bcb07ce3ff9ca3645bd59aa6",
                "Content-Type":"multipart/form-data; boundary=\(boundary)"
            ]
        }
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var bodyParameters: Optional<UploadFileParameters> {
        guard case let UploadContentNetworkService.upload(localUrl, type, _) = self else { return nil }
        return [
            [
                "key": type.rawValue,
                "src": localUrl.absoluteString,
                "type": "file"
            ]
        ]
    }
    
    var body: Optional<Data> {
        guard let parameters = bodyParameters?.first,
              case let UploadContentNetworkService.upload(_, _, boundary) = self else { return nil }
        
        var data = Data()

        let fileName = parameters["src"] as! String
        let imageData = try! NSData(contentsOfFile: fileName, options:[]) as Data
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\("image")\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(imageData)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        return data
    }
    
    var urlRequest: Optional<URLRequest> {
        guard let url = URL(string: baseUrl + path), let body = body else { return nil }
        var request = URLRequest(url: url, timeoutInterval: 5)
        
        request.httpMethod = method.rawValue
        headers.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = body
        
        return request
    }
}
