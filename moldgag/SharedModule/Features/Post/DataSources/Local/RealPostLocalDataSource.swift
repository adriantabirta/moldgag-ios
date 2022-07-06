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
    
    private let currentValueSubject = CurrentValueSubject<Array<PostLocalDataModel>, DatabaseError>([])
    
}

// MARK: - PostLocalDataSource

extension RealPostLocalDataSource: PostLocalDataSource {
    
    func upsert(_ posts: Array<PostLocalDataModel>) {
        switch getPostsFromStorage() {
        case let .success(localPosts):

            var postsSet = localPosts.reduce(into: Set<PostLocalDataModel>()) { $0.insert($1) }
            posts.forEach { postsSet.insert($0) }

            print("save: \(postsSet.count)")
            localStorageService.save(postsSet, key: key)
            currentValueSubject.send(Array(postsSet))

        case .failure(_):
            localStorageService.save(posts, key: key)
            currentValueSubject.send(posts)
        }
    }
    
    func postsStream() -> AnyPublisher<Array<PostLocalDataModel>, DatabaseError> {
//        switch getPostsFromStorage() {
//        case let .success(posts): currentValueSubject.send(posts)
//        case let .failure(error):
//            _ = error
//            currentValueSubject.send([])
//        }
        return currentValueSubject.eraseToAnyPublisher()
    }
    
    func deleteAll() -> AnyPublisher<Void, Never> {
        Future { promise in
            self.localStorageService.save([PostLocalDataModel](), key: self.key)
            promise(.success(()))
        }.eraseToAnyPublisher()
    }
}

// MARK: - Private

private extension RealPostLocalDataSource {
    
    func getPostsFromStorage() -> Result<[PostLocalDataModel], DatabaseError> {
        if let posts = self.localStorageService.get(Array<PostLocalDataModel>.self, key: self.key) {
            return .success(posts)
        } else {
            return .failure(DatabaseError.unableToRead("Cannot find key: \(self.key)"))
        }
    }
}
