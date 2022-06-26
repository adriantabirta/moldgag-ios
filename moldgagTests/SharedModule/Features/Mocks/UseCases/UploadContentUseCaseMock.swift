//
//  UploadContentUseCaseMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import Foundation
@testable import moldgag

class UploadContentUseCaseMock: UploadContentUseCase {

    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (url: URL, postType: PostType)?
    var invokedExecuteParametersList = [(url: URL, postType: PostType)]()
    var stubbedExecuteResult: AnyPublisher<UploadResponseRemoteDataModel, ApplicationError>!

    func execute(url: URL, postType: PostType) -> AnyPublisher<UploadResponseRemoteDataModel, ApplicationError> {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (url, postType)
        invokedExecuteParametersList.append((url, postType))
        return stubbedExecuteResult
    }
}
