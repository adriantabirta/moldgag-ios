//
//  GetVideoAssetUseCaseTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
import Combine
import Resolver
@testable import moldgag
import AVFoundation

class GetVideoAssetUseCaseTests: XCTestCase {
    
    private var videoRepository: VideoRepositoryMock!
    
    private var tested: GetVideoAssetUseCase!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        self.videoRepository = Resolver.resolveMock(VideoRepository.self)
        self.tested = RealGetVideoAssetUseCase()
        self.cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        self.videoRepository = nil
        self.tested = nil
        self.cancellables = nil
        Resolver.resetForUnitTests()
    }
    
    func testExecuteWithSuccess() {
        let urlStub = URL(string: "sds")!
        let avAssetStub = AVAsset(url: urlStub)
        videoRepository.stubbedGetVideoAssetForResult = avAssetStub
        let asset = tested.execute(for: urlStub)
     
        
        XCTAssertEqual(videoRepository.invokedGetVideoAssetForCount, 1, "Should be called only once.")
    }
    
}
