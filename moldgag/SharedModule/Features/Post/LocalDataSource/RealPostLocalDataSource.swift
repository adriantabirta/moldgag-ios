//
//  RealPostLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Resolver
import RealmSwift
import Foundation

class RealPostLocalDataSource {
    
    // MARK: - Dependencies
    
    @Injected var storageContext: StorageContext
    
}

extension RealPostLocalDataSource: PostLocalDataSource {
    
    func getPosts(for page: Int) -> AnyPublisher<Array<PostLocalDataModel>, DatabaseError> {
        storageContext.fetch(PostLocalDataModel.self, predicate: nil, sorted: nil).eraseToAnyPublisher()
    }
}
