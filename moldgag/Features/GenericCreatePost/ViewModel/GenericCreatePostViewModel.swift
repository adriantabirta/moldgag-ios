//
//  GenericCreatePostViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 15.07.2022.
//

import Combine
import Resolver
import Foundation

class GenericCreatePostViewModel {
    
    // MARK: - Dependencies
    
    @Injected var createPostUseCase: CreatePostUseCase
    
    // MARK: - Properties
    
    private let mediaUrl: URL
    
    private let postType: PostType
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(mediaUrl: URL, postType: PostType) {
        self.mediaUrl = mediaUrl
        self.postType = postType
    }
}

// MARK: - Public

extension GenericCreatePostViewModel {
    
    func createPost(with title: String) {
        createPostUseCase
            .execute(title: title, localFileUrl: mediaUrl, postType: postType)
            .sink(receiveCompletion: { completion in
                _ = completion
            }, receiveValue: { post in
                // dismiss
            })
            .store(in: &cancellables)
    }
}
