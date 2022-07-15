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
        let urlStub = URL(string: "https://www.some.com/file.mp4")!
        let avAssetStub = AVAsset(url: urlStub)
        videoRepository.stubbedGetVideoAssetForResult = avAssetStub
        let result = tested.execute(for: urlStub)
     
        XCTAssertEqual((result as! AVURLAsset).url, (avAssetStub as! AVURLAsset).url , "Should be called only once.")
        XCTAssertEqual(videoRepository.invokedGetVideoAssetForCount, 1, "Should be called only once.")
    }
    
}
