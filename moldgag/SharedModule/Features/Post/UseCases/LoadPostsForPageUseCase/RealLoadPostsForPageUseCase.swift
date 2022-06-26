//
//  RealGetPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Resolver

class RealLoadPostsForPageUseCase: LoadPostsForPageUseCase {
    
    // MARK: - Dependencies
    
    @Injected var postRepository: PostRepository
    
}

// MARK: - GetPostsUseCase

extension RealLoadPostsForPageUseCase {
        
    func execute(for page: Int) -> AnyPublisher<Void, Never> {
        postRepository.loadPosts(for: page)
    }
}

