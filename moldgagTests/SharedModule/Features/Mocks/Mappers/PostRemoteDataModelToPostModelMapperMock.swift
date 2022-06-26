//
//  PostRemoteDataModelToPostModelMapperMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

@testable import moldgag

class PostRemoteDataModelToPostModelMapperMock: PostRemoteDataModelToPostModelMapper {

    var invokedMap = false
    var invokedMapCount = 0
    var invokedMapParameters: (model: PostRemoteDataModel, Void)?
    var invokedMapParametersList = [(model: PostRemoteDataModel, Void)]()
    var stubbedMapResult: PostModel!

    func map(from model: PostRemoteDataModel) -> PostModel? {
        invokedMap = true
        invokedMapCount += 1
        invokedMapParameters = (model, ())
        invokedMapParametersList.append((model, ()))
        return stubbedMapResult
    }
}
