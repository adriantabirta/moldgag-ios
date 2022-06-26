//
//  PostLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine

protocol PostLocalDataSource {
    
    func save(_ posts: Array<PostLocalDataModel>)
    
    func getPosts() -> AnyPublisher<Array<PostLocalDataModel>, DatabaseError>
    
    func deleteAll() -> AnyPublisher<Void, Never>
}
