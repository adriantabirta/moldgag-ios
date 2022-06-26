//
//  LoadPostsForPageUseCaseMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
@testable import moldgag

class LoadPostsForPageUseCaseMock: LoadPostsForPageUseCase {
    
    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (page: Int, Void)?
    var invokedExecuteParametersList = [(page: Int, Void)]()
    var stubbedExecuteResult: AnyPublisher<Void, Never>!
    
    func execute(for page: Int) -> AnyPublisher<Void, Never> {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (page, ())
        invokedExecuteParametersList.append((page, ()))
        return stubbedExecuteResult
    }
}
