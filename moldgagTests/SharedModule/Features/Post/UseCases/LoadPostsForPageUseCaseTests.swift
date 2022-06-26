//
//  LoadPostsForPageUseCaseTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
import Combine
import Resolver
@testable import moldgag

class LoadPostsForPageUseCaseTests: XCTestCase {
    
    private var postRepository: PostRepositoryMock!
  
    private var tested: LoadPostsForPageUseCase!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        self.postRepository = Resolver.resolveMock(PostRepository.self)
        postRepository.stubbedLoadPostsResult = Just(()).eraseToAnyPublisher()

        self.tested = RealLoadPostsForPageUseCase()
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
        let expectation = expectation(description: "LoadPostsForPageUseCaseTests::testExecuteWithSuccess")
        self.postRepository.stubbedLoadPostsResult = Just(()).eraseToAnyPublisher()
        
        tested.execute(for: 0)
            .sink(receiveCompletion: { completion in
                if case let .failure(_) = completion {
                    XCTFail("Should not fail")
                }
            }, receiveValue: { postModel in
//                XCTAssertEqual(postModel, postModelStub, "Should be the same.")
//                XCTAssertEqual(self.postRepository.invokedCreateCount, 1, "Should be called only once")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
}
