//
//  PostRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Foundation

protocol PostRemoteDataSource {
    
    func getPosts(for page: Int) -> AnyPublisher<PostsRemoteDataModel, NetworkError>
    
    func create(from url: String, title: String, and postType: PostType) -> AnyPublisher<PostRemoteDataModel, NetworkError>
    
}
