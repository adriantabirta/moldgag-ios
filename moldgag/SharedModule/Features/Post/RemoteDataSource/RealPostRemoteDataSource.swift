//
//  RealPostRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Resolver
import Foundation

class RealPostRemoteDataSource {
    
    // MARK: - Dependencies
    
    @Injected var networkServiceProvider: NetworkServiceProvider<PostNetworkService>
    
    // MARK: - Proprieties
    
    private var bag = Set<AnyCancellable>()
    
}

// MARK: - PostRemoteDataSource

extension RealPostRemoteDataSource: PostRemoteDataSource {
    
    func getPosts(for page: Int) -> AnyPublisher<PostsRemoteDataModel, ApplicationError> {
//        let request: AnyPublisher<PostsRemoteDataModel, ApplicationError> = networkServiceProvider.requestMock(enpoint: .posts(page: page))
//        return request.eraseToAnyPublisher()
        
        return networkServiceProvider.requestMock(enpoint: .posts(page: page))
            .mapError { ApplicationError.network($0) }
            .eraseToAnyPublisher()
    }
    
    func create(from url: String, title: String, and postType: PostType) -> AnyPublisher<PostRemoteDataModel, ApplicationError> {
        let endpoint: PostNetworkService = .create(title: title, url: url, postType: postType)
        return networkServiceProvider
            .requestMock(enpoint: endpoint)
            .mapError { ApplicationError.network($0) }
            .eraseToAnyPublisher()
    }
    
}
