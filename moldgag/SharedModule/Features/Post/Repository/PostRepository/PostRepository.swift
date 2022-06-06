//
//  PostRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine

protocol PostRepository {
    
    func getPosts(for page: Int) -> AnyPublisher<PostsModel, ApplicationError>
    
}
