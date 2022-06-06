//
//  GetPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine

public protocol GetPostsUseCase {
    
    func execute(for page: Int) -> AnyPublisher<PostsModel, ApplicationError>
}
