//
//  PostLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine

protocol PostLocalDataSource {
    
    func upsert(_ posts: Array<PostLocalDataModel>)
    
    func postsStream() -> AnyPublisher<Array<PostLocalDataModel>, DatabaseError>
    
    func deleteAll() -> AnyPublisher<Void, Never>
}
