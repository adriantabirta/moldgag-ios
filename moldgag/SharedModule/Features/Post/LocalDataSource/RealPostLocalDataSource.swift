//
//  RealPostLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Combine
import Resolver
import Foundation

class RealPostLocalDataSource {
    
    // MARK: - Dependencies
    
    @Injected var localStorageService: LocalStorageService
    
    // MARK: - Propreties
    
    private let key = "Posts"

}

extension RealPostLocalDataSource: PostLocalDataSource {

    func save(_ posts: Array<PostLocalDataModel>) {
        localStorageService.save(posts, key: key)
    }

    func getPosts() -> AnyPublisher<Array<PostLocalDataModel>, DatabaseError> {
        Future { promise in
            if let posts = self.localStorageService.get(Array<PostLocalDataModel>.self, key: self.key) {
                promise(.success(posts))
            } else {
                promise(.failure(DatabaseError.unableToRead("Cannot find key: \(self.key)")))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteAll() -> AnyPublisher<Void, Never> {
        Future { promise in
            self.localStorageService.remove(key: self.key)
            promise(.success(()))
        }.eraseToAnyPublisher()
    }
}
