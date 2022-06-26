//
//  PostRepositoryMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import Foundation
@testable import moldgag

class PostRepositoryMock: PostRepository {

    var invokedLoadPosts = false
    var invokedLoadPostsCount = 0
    var invokedLoadPostsParameters: (page: Int, Void)?
    var invokedLoadPostsParametersList = [(page: Int, Void)]()
    var stubbedLoadPostsResult: AnyPublisher<Void, Never>!

    func loadPosts(for page: Int) -> AnyPublisher<Void, Never> {
        invokedLoadPosts = true
        invokedLoadPostsCount += 1
        invokedLoadPostsParameters = (page, ())
        invokedLoadPostsParametersList.append((page, ()))
        return stubbedLoadPostsResult
    }

    var invokedGetPosts = false
    var invokedGetPostsCount = 0
    var stubbedGetPostsResult: AnyPublisher<Array<PostModel>, Never>!

    func getPosts() -> AnyPublisher<Array<PostModel>, Never> {
        invokedGetPosts = true
        invokedGetPostsCount += 1
        return stubbedGetPostsResult
    }

    var invokedDeleteAll = false
    var invokedDeleteAllCount = 0
    var stubbedDeleteAllResult: AnyPublisher<Void, Never>!

    func deleteAll() -> AnyPublisher<Void, Never> {
        invokedDeleteAll = true
        invokedDeleteAllCount += 1
        return stubbedDeleteAllResult
    }

    var invokedCreate = false
    var invokedCreateCount = 0
    var invokedCreateParameters: (localFileUrl: URL, title: String, postType: PostType)?
    var invokedCreateParametersList = [(localFileUrl: URL, title: String, postType: PostType)]()
    var stubbedCreateResult: AnyPublisher<PostModel, ApplicationError>!

    func create(localFileUrl: URL, title: String, postType: PostType) -> AnyPublisher<PostModel, ApplicationError> {
        invokedCreate = true
        invokedCreateCount += 1
        invokedCreateParameters = (localFileUrl, title, postType)
        invokedCreateParametersList.append((localFileUrl, title, postType))
        return stubbedCreateResult
    }
}
