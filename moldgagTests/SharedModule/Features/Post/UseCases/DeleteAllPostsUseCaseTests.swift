//
//  DeleteAllPostsUseCaseTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
import Combine
import Resolver
@testable import moldgag

class DeleteAllPostsUseCaseTests: XCTestCase {
    
    private var postRepository: PostRepositoryMock!
    
    private var videoRepository: VideoRepositoryMock!
        
    private var tested: DeleteAllPostsUseCase!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        self.postRepository = Resolver.resolveMock(PostRepository.self)
        self.videoRepository = Resolver.resolveMock(VideoRepository.self)
        
        self.tested = RealDeleteAllPostsUseCase()
        self.cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        self.postRepository = nil
        self.videoRepository = nil
        self.tested = nil
        self.cancellables = nil
        Resolver.resetForUnitTests()
    }
    
    func testExecuteWithSuccess() {
        let expectation = expectation(description: "DeleteAllPostsUseCaseTests::testExecuteWithSuccess")
        postRepository.stubbedDeleteAllResult = Just(()).eraseToAnyPublisher()
        videoRepository.stubbedDeleteAllResult = Just(()).eraseToAnyPublisher()
        
        tested.execute().sink(receiveValue: {
            expectation.fulfill()
        }).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(postRepository.invokedDeleteAllCount, 1, "Should be called only once.")
        XCTAssertEqual(videoRepository.invokedDeleteAllCount, 1, "Should be called only once.")
    }
    
}
