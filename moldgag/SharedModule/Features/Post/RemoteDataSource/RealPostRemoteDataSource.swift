//
//  RealPostRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Resolver
import Foundation

class RealPostRemoteDataSource: PostRemoteDataSource {
    
    // MARK: - Dependencies
    
    @Injected var networkServiceProvider: NetworkServiceProvider<PostNetworkService>
    
    // MARK: - Proprieties
    
    private var bag = Set<AnyCancellable>()
    
}

// MARK: - PostRemoteDataSource

extension RealPostRemoteDataSource {
    
    func getPosts(for page: Int) -> AnyPublisher<PostsRemoteDataModel, NetworkError> {
        let request: AnyPublisher<PostsRemoteDataModel, NetworkError> = networkServiceProvider.requestMock(enpoint: .posts(page: page))
        return request.eraseToAnyPublisher()
    }
    
    func create(from url: String, title: String, and postType: PostType) -> AnyPublisher<PostRemoteDataModel, NetworkError> {
        let endpoint: PostNetworkService = .create(title: title, url: url, postType: postType)
        return networkServiceProvider.requestMock(enpoint: endpoint).eraseToAnyPublisher()
    }

}
