//
//  GetPostsUseCaseMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
@testable import moldgag

class GetPostsUseCaseMock: GetPostsUseCase {

    var invokedExecute = false
    var invokedExecuteCount = 0
    var stubbedExecuteResult: AnyPublisher<Array<PostModel>, Never>!

    func execute() -> AnyPublisher<Array<PostModel>, Never> {
        invokedExecute = true
        invokedExecuteCount += 1
        return stubbedExecuteResult
    }
}
