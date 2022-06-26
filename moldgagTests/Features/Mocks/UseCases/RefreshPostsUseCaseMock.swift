//
//  RefreshPostsUseCaseMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
@testable import moldgag

class RefreshPostsUseCaseMock: RefreshPostsUseCase {
    
    var invokedExecute = false
    var invokedExecuteCount = 0
    var stubbedExecuteResult: AnyPublisher<Void, Never>!
    
    func execute() -> AnyPublisher<Void, Never> {
        invokedExecute = true
        invokedExecuteCount += 1
        return stubbedExecuteResult
    }
}
