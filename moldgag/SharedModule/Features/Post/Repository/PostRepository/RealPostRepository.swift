//
//  RealPostRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Resolver

class RealPostRepository: PostRepository {
    
    // MARK: - Dependencies
    
    @Injected var postLocalDataSource: PostLocalDataSource
    
    @Injected var postRemoteDataSource: PostRemoteDataSource
    
    @Injected var postLocalDataModelToPostMapper: PostLocalDataModelToPostMapper
    
    @Injected var postRemoteDataModelToPostMapper: PostRemoteDataModelToPostModelMapper
    
}

// MARK: - PostRepository

extension RealPostRepository {
    
    func getPosts(for page: Int) -> AnyPublisher<PostsModel, ApplicationError> {
        
        let local = postLocalDataSource.getPosts(for: page)
            .map({ $0.compactMap({ self.postLocalDataModelToPostMapper.map(from: $0) }) })
            .map({ PostsModel(posts: $0) })
            .mapError({ ApplicationError.database($0) })
            
        let remote = postRemoteDataSource.getPosts(for: page)
            .map({ [self] in $0.posts.compactMap({ postRemoteDataModelToPostMapper.map(from: $0) }) })
            .map({ PostsModel(posts: $0) })
            .mapError({ ApplicationError.network($0) })
        
        return Publishers.Merge(local, remote).eraseToAnyPublisher()
    }
}
