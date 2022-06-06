//
//  CreatePostUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 05.06.2022.
//

import Combine
import Foundation

protocol CreatePostUseCase {
    
    func execute(contentTouple: ContentTouple) -> AnyPublisher<PostModel, ApplicationError>
    
}
