//
//  CreatePostUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 05.06.2022.
//

import Combine
import Foundation

protocol CreatePostUseCase {
    
    func execute(title: String, localFileUrl: URL, postType: PostType) -> AnyPublisher<PostModel, ApplicationError>
    
}
