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
    
    @Injected private var videoCacheService: VideoCacheService
    
    @Injected private var imageCacheService: ImageCacheService
    
}

extension RealDeleteAllPostsUseCase: DeleteAllPostsUseCase {
    
    func execute() -> AnyPublisher<Void, Never> {
        Publishers.CombineLatest3(postRepository.deleteAll(), videoCacheService.deleteAllCache(), imageCacheService.deleteAllCache())
            .map{ _, _, _ in Void() }
            .eraseToAnyPublisher()
    }
}
