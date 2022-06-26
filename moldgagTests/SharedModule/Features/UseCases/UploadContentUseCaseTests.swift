//
//  UploadContentUseCaseTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
import Combine
import Resolver
@testable import moldgag

class UploadContentUseCaseTests: XCTestCase {

    private var tested: UploadContentUseCase!
    
    private var uploadContentRemoteDataSource: UploadContentRemoteDataSourceMock!
    
    private var postRemoteDataSource: PostRemoteDataSourceMock!
    
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        self.tested = RealUploadContentUseCase()
        self.uploadContentRemoteDataSource = Resolver.resolveMock(UploadContentRemoteDataSource.self)
        self.postRemoteDataSource = Resolver.resolveMock(PostRemoteDataSource.self)
        self.cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        self.tested = nil
        self.uploadContentRemoteDataSource = nil
        self.postRemoteDataSource = nil
        self.cancellables = nil
        Resolver.resetForUnitTests()
    }
    
    func testExecuteWithSuccess() {
        let stubUrl = URL(string: "https://test.upload")!
        
        tested.execute(url: stubUrl, postType: .image)
            .sink(receiveCompletion: { completion in
                if case let .failure(applicationError) = completion {
                    _ = applicationError
                    XCTFail("This should not return an error")
                }
            }, receiveValue: { model in
                //
            })
            .store(in: &cancellables)
    }
    
    
}
