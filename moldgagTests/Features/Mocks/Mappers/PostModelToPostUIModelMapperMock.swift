//
//  PostModelToPostUIModelMapperMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
@testable import moldgag

class PostModelToPostUIModelMapperMock: PostModelToPostUIModelMapper {

    var invokedMap = false
    var invokedMapCount = 0
    var invokedMapParameters: (model: Array<PostModel>, Void)?
    var invokedMapParametersList = [(model: Array<PostModel>, Void)]()
    var stubbedMapResult: Array<VideoPostUIModel>! = []

    func map(from model: Array<PostModel>) -> Array<VideoPostUIModel> {
        invokedMap = true
        invokedMapCount += 1
        invokedMapParameters = (model, ())
        invokedMapParametersList.append((model, ()))
        return stubbedMapResult
    }
}
