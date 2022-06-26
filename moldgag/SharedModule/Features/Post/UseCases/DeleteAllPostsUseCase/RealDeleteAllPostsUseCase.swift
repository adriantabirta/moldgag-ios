//
//  RealDeleteAllPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Combine
import Resolver

class RealDeleteAllPostsUseCase {
    
    // MARK: - Dependencies
    
    @Injected private var postRepository: PostRepository
    
    @Injected private var videoRepository: VideoRepository
    
    @Injected private var imageCacheService: ImageCacheService
    
}

// MARK: - DeleteAllPostsUseCase

extension RealDeleteAllPostsUseCase: DeleteAllPostsUseCase {
    
    func execute() -> AnyPublisher<Void, Never> {
        Publishers.Zip3(postRepository.deleteAll(), videoRepository.deleteAll(), imageCacheService.deleteAllCache())
            .map{ _, _, _ in Void() }
            .eraseToAnyPublisher()
    }
}
