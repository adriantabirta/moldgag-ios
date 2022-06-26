//
//  GetPostsStreamUseCaseTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
import Combine
import Resolver
@testable import moldgag

class GetPostsStreamUseCaseTests: XCTestCase {
    
    private var postRepository: PostRepositoryMock!
    
    private var tested: GetPostsStreamUseCase!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        self.postRepository = Resolver.resolveMock(PostRepository.self)
        self.tested = RealGetPostsStreamUseCase()
        self.cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        self.postRepository = nil
        self.tested = nil
        self.cancellables = nil
        Resolver.resetForUnitTests()
    }
    
    func testExecuteWithSuccess() {
        let expectation = expectation(description: "GetPostsStreamUseCaseTests::testExecuteWithSuccess")
        let arrayStub = [PostModel.stub()]
        postRepository.stubbedGetPostsResult = Just(arrayStub).eraseToAnyPublisher()
        
        tested.execute().sink(receiveValue: { array in
            expectation.fulfill()
            XCTAssertEqual(array, arrayStub, "Should be the same array.")
        })
        .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(postRepository.invokedGetPostsCount, 1, "Should be called only once.")
    }
    
}
