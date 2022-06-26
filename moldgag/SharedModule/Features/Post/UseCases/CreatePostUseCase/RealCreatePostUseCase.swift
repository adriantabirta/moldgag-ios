//
//  RealCreatePostUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 05.06.2022.
//

import Combine
import Resolver
import Foundation

class RealCreatePostUseCase {
    
    // MARK: - Dependencies
    
    @Injected var postRepository: PostRepository
    
}

// MARK: - CreatePostUseCase

extension RealCreatePostUseCase: CreatePostUseCase  {
    
    func execute(title: String, localFileUrl: URL, postType: PostType) -> AnyPublisher<PostModel, ApplicationError> {
        postRepository.create(localFileUrl: localFileUrl, title: title, postType: postType)
    }
}
