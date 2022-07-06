//
//  RealGetPostsStreamUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Combine
import Resolver

class RealGetPostsStreamUseCase {
    
    // MARK: - Dependencies
    
    @Injected var postRepository: PostRepository
    
}

// MARK: - GetPostsStreamUseCase

extension RealGetPostsStreamUseCase: GetPostsStreamUseCase {
    
    func execute() -> AnyPublisher<Array<PostModel>, Never> {
        postRepository.postsStream()
    }
}
