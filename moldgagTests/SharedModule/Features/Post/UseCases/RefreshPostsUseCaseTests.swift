//
//  RefreshPostsUseCaseTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
import Combine
import Resolver
@testable import moldgag

class RefreshPostsUseCaseTests: XCTestCase {
    
    private var deleteAllPostsUseCase: DeleteAllPostsUseCaseMock!
    
    private var loadPostsForPageUseCase: LoadPostsForPageUseCaseMock!
    
    private var tested: RefreshPostsUseCase!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        self.deleteAllPostsUseCase = Resolver.resolveMock(DeleteAllPostsUseCase.self)
        self.loadPostsForPageUseCase = Resolver.resolveMock(LoadPostsForPageUseCase.self)
        self.tested = RealRefreshPostsUseCase()
        self.cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        self.deleteAllPostsUseCase = nil
        self.loadPostsForPageUseCase = nil
        self.tested = nil
        self.cancellables = nil
        Resolver.resetForUnitTests()
    }
    
    func testExecuteWithSuccess() {
        let expectation = expectation(description: "RefreshPostsUseCaseTests::testExecuteWithSuccess")
        deleteAllPostsUseCase.stubbedExecuteResult = Just(()).eraseToAnyPublisher()
        loadPostsForPageUseCase.stubbedExecuteResult = Just(()).eraseToAnyPublisher()
        
        tested.execute().sink(receiveValue: {
            expectation.fulfill()
        }).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(deleteAllPostsUseCase.invokedExecuteCount, 1, "Should be called only once.")
        XCTAssertEqual(loadPostsForPageUseCase.invokedExecuteCount, 1, "Should be called only once.")
    }
    
}
