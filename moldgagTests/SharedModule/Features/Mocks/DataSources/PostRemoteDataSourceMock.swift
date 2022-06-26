//
//  PostRemoteDataSourceMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
//import Resolver
@testable import moldgag

class PostRemoteDataSourceMock: PostRemoteDataSource {

    var invokedGetPosts = false
    var invokedGetPostsCount = 0
    var invokedGetPostsParameters: (page: Int, Void)?
    var invokedGetPostsParametersList = [(page: Int, Void)]()
    var stubbedGetPostsResult: AnyPublisher<PostsRemoteDataModel, ApplicationError>!

    func getPosts(for page: Int) -> AnyPublisher<PostsRemoteDataModel, ApplicationError> {
        invokedGetPosts = true
        invokedGetPostsCount += 1
        invokedGetPostsParameters = (page, ())
        invokedGetPostsParametersList.append((page, ()))
        return stubbedGetPostsResult
    }

    var invokedCreate = false
    var invokedCreateCount = 0
    var invokedCreateParameters: (url: String, title: String, postType: PostType)?
    var invokedCreateParametersList = [(url: String, title: String, postType: PostType)]()
    var stubbedCreateResult: AnyPublisher<PostRemoteDataModel, ApplicationError>!

    func create(from url: String, title: String, and postType: PostType) -> AnyPublisher<PostRemoteDataModel, ApplicationError> {
        invokedCreate = true
        invokedCreateCount += 1
        invokedCreateParameters = (url, title, postType)
        invokedCreateParametersList.append((url, title, postType))
        return stubbedCreateResult
    }
}
