//
//  RealGetPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Combine
import Resolver

class RealGetPostsUseCase {
    
    // MARK: - Dependencies
    @Injected var postRepository: PostRepository
    
}

extension RealGetPostsUseCase: GetPostsUseCase {
    
    func execute() -> AnyPublisher<Array<PostModel>, Never> {
        postRepository.getPosts()
    }
}
