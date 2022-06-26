//
//  RealUploadContentRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 02.06.2022.
//

import Combine
import Resolver
import Foundation

class RealUploadContentRemoteDataSource {
    
    // MARK: - Dependencies
    
    @Injected var networkService: NetworkServiceProvider<UploadContentNetworkService>
   
}

// MARK: - UploadContentRemoteDataSource

extension RealUploadContentRemoteDataSource: UploadContentRemoteDataSource {
    
    func upload(url: URL, postType: PostType) -> AnyPublisher<UploadResponseRemoteDataModel, ApplicationError> {        
        networkService.requestMock(enpoint: .upload(localUrl: url, type: postType))
            .mapError({ ApplicationError($0) })
            .eraseToAnyPublisher()
    }
}
