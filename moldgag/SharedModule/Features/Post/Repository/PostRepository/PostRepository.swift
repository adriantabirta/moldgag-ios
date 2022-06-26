//
//  PostRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Foundation

protocol PostRepository {
    
    func loadPosts(for page: Int) -> AnyPublisher<Void, Never>
    
    func getPosts() -> AnyPublisher<Array<PostModel>, Never>
    
    func deleteAll() -> AnyPublisher<Void, Never>
    
    func create(localFileUrl: URL, title: String, postType: PostType) -> AnyPublisher<PostModel, ApplicationError>
    
}
