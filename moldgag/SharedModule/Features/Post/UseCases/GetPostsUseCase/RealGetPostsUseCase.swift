//
//  RealGetPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Resolver

class RealGetPostsUseCase: GetPostsUseCase {
    
    // MARK: - Dependencies
    
    @Injected var postRepository: PostRepository
    
}

// MARK: - GetPostsUseCase

extension RealGetPostsUseCase {
    
    func execute(for page: Int) -> AnyPublisher<PostsModel, ApplicationError> {
        postRepository.getPosts(for: page).eraseToAnyPublisher()
    }
}

