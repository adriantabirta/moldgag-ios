//
//  PostLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine

protocol PostLocalDataSource {
    
    func getPosts(for page: Int) -> AnyPublisher<Array<PostLocalDataModel>, DatabaseError>
    
}
