//
//  CreatePostUseCaseTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
import Combine
import Resolver
@testable import moldgag

class CreatePostUseCaseTests: XCTestCase {
    
    private var postRepository: PostRepositoryMock!
  
    private var tested: RealCreatePostUseCase!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        self.tested = RealCreatePostUseCase()
        self.postRepository = Resolver.resolveMock(PostRepository.self)
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
        let titleStub = "Moldgag test title"
        let localFileUrlStub = URL(string: "file://file.mp4")!
        let postTypeStub = PostType.image
        let postModelStub = PostModel.stub()
        let expectation = expectation(description: "CreatePostUseCaseTests::testExecuteWithSuccess")

        self.postRepository.stubbedCreateResult = Just(postModelStub).setFailureType(to: ApplicationError.self).eraseToAnyPublisher()
        
        tested.execute(title: titleStub, localFileUrl: localFileUrlStub, postType: postTypeStub)
            .sink(receiveCompletion: { completion in
                if case let .failure(_) = completion {
                    XCTFail("Should not fail")
                }
            }, receiveValue: { postModel in
                XCTAssertEqual(postModel, postModelStub, "Should be the same.")
                XCTAssertEqual(self.postRepository.invokedCreateCount, 1, "Should be called only once")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

}
