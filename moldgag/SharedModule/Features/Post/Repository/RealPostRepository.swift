//
//  RealPostRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Resolver
import Foundation

class RealPostRepository {
    
    // MARK: - Dependencies
    
    @Injected var uploadContentRemoteDataSource: UploadContentRemoteDataSource
    
    @Injected var postLocalDataSource: PostLocalDataSource
    
    @Injected var postRemoteDataSource: PostRemoteDataSource
    
    @Injected var postRemoteModelToPostLocalDataModelMapper: PostRemoteDataModelToPostLocalDataModelMapper
    
    @Injected var postLocalDataModelToPostMapper: PostLocalDataModelToPostMapper
    
    @Injected var postRemoteDataModelToPostModelMapper: PostRemoteDataModelToPostModelMapper
    
    // MARK: - Propreties

    private let passthroughSubject = PassthroughSubject<Array<PostModel>, Never>()
    
    private var bag = Set<AnyCancellable>()
    
}

// MARK: - PostRepository

extension RealPostRepository: PostRepository {
    
    func loadPosts(for page: Int) -> AnyPublisher<Void, Never> {
        postRemoteDataSource.getPosts(for: page)
            .map({ $0.posts })
            .map({ self.postRemoteModelToPostLocalDataModelMapper.map(from: $0) })
            .handleEvents(receiveOutput: { self.postLocalDataSource.upsert($0) })
            .handleEvents(receiveCompletion: { completion in
                // handle error here
                // error handler
            })
            .map({ _ in Void() })
            .replaceError(with: ())
            .eraseToAnyPublisher()
    }
    
    func postsStream() -> AnyPublisher<Array<PostModel>, Never> {
        postLocalDataSource.postsStream()
            .map({ $0.compactMap({ self.postLocalDataModelToPostMapper.map(from: $0) }) })
            .mapError({ ApplicationError.database($0) }) // todo: handle error
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func deleteAll() -> AnyPublisher<Void, Never> {
        postLocalDataSource.deleteAll()
    }
    
    func create(localFileUrl: URL, title: String, postType: PostType) -> AnyPublisher<PostModel, ApplicationError> {
        uploadContentRemoteDataSource.upload(url: localFileUrl, postType: postType)
            .flatMap { self.postRemoteDataSource.create(from: $0.data.link, title: title, and: postType) }
            .compactMap { self.postRemoteDataModelToPostModelMapper.map(from: $0) }
            .eraseToAnyPublisher()
    }
}
