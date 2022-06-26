//
//  VerticalScrollablePageViewModelTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
import Combine
import Resolver
import AVFoundation
@testable import moldgag

class VerticalScrollablePageViewModelTests: XCTestCase {
    
    private var tested: VerticalScrollablePageViewModel!
    private var loadPostsForPageUseCase: LoadPostsForPageUseCaseMock!
    private var refreshPostsUseCase: RefreshPostsUseCaseMock!
    private var getPostsUseCase: GetPostsUseCaseMock!
    private var postModelToPostUIModelMapper: PostModelToPostUIModelMapperMock!
    private var postUIModelToUIViewControllerMapper: PostUIModelToUIViewControllerMapperMock!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        Resolver.registerForUnitTests()
        let stub = VerticalScrollablePageUIModel.stub()
        self.tested = VerticalScrollablePageViewModel(verticalScrollablePageUIModel: stub)
        
        self.loadPostsForPageUseCase = Resolver.resolveMock(LoadPostsForPageUseCase.self)
        self.refreshPostsUseCase = Resolver.resolveMock(RefreshPostsUseCase.self)
        self.getPostsUseCase = Resolver.resolveMock(GetPostsUseCase.self)
        self.postModelToPostUIModelMapper = Resolver.resolveMock(PostModelToPostUIModelMapper.self)
        self.postUIModelToUIViewControllerMapper = Resolver.resolveMock(PostUIModelToUIViewControllerMapper.self)
        
        self.cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        self.tested = nil
        self.cancellables = nil
        Resolver.resetForUnitTests()
    }
    
    func testVideoShouldBeCached() {
        tested.items
        
        
   
    }

}
