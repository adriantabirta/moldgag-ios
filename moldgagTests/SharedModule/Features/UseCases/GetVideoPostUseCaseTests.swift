//
//  GetVideoPostUseCaseTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import XCTest
import Combine
import Resolver
import AVFoundation
@testable import moldgag

class GetVideoPostUseCaseTests: XCTestCase {

    private var service: VideoCacheServiceMock!

    private var mapper: FilenameToLocalPathMapperMock!

    private var tested: RealGetVideoPostUseCase!

    private var localUrl: URL!

    private var remoteUrl: URL!
    
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        self.service = Resolver.resolveMock(VideoCacheService.self)
        self.mapper = Resolver.resolveMock(FilenameToLocalPathMapper.self)
        self.tested = RealGetVideoPostUseCase()
        
        self.localUrl = URL(string: "https://www.some.com/file.mp4")
        self.remoteUrl = URL(string: "https://www.remote.com/file.mp4")
        self.cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        self.service = nil
        self.mapper = nil
        self.tested = nil
        self.localUrl = nil
        self.remoteUrl = nil
        self.cancellables = nil
        Resolver.resetForUnitTests()
    }
    
    func testVideoShouldBeCached() {
        let current = tested.execute(for: localUrl)
        XCTAssertEqual((current as! AVURLAsset).url, localUrl, "should return the same url while is caching")
        XCTAssertEqual(service.invokedCacheAssetCount, 1, "should be invoked once")
    }
    
    func testVideoUrlShouldBeReturedFromCache() {
        
        let expected = Optional(localUrl)
        mapper.stubbedMapResult = expected
        
        let current = tested.execute(for: localUrl)
       
        XCTAssertEqual(mapper.invokedMapCount, 1, "should be invoked once")
        
        // XCTAssertEqual(FileManager.default.fileExists(atPath: localUrl.path), true, "file shouldl be stored locally")
        XCTAssertEqual((current as! AVURLAsset).url, expected, "should return the same url while is caching")
    }
}
