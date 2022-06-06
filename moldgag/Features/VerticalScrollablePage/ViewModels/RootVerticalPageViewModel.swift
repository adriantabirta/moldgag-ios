//
//  VerticalScrollablePageViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import UIKit
import Combine
import Resolver
import Foundation

class VerticalScrollablePageViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    @Injected var videoCacheService: VideoCacheService
    
    @Injected var getPostsUseCase: GetPostsUseCase
    
    @Injected var postModelToPostUIModelMapper: PostModelToPostUIModelMapper
    
    @Injected var postUIModelToUIViewControllerMapper: PostUIModelToUIViewControllerMapper
    
    
    // MARK: - Proprieties
    @Published var verticalScrollablePageUIModel: VerticalScrollablePageUIModel
    
    @Published var items: Array<VideoPostUIModel> = .init()
    
    @Published var firstViewControllerPublishd: UIViewController = .init()
    
    private var bag = Set<AnyCancellable>()
    
    var isLoading: Bool = false {
        didSet {
            print("is loading \(isLoading)")
        }
    }
    
    var currentIndex: Int = 0 {
        didSet {
            print("current index \(currentIndex)")
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            print("current page \(currentPage)")
        }
    }
    
    init(verticalScrollablePageUIModel: VerticalScrollablePageUIModel) {
        self.verticalScrollablePageUIModel = verticalScrollablePageUIModel
        // todo: move up and load only first 3 elements
        // todo: make here request to get new data
        // videoCacheService.preCacheItems(items)
    }
}

extension VerticalScrollablePageViewModel {
    
    func loadFirstPage() {
        isLoading = true
        getPostsUseCase.execute(for: 0)
            .map({ $0.posts })
            .compactMap({ $0.compactMap({ self.postModelToPostUIModelMapper.map(from: $0) }) })
            .handleEvents(receiveOutput: { _ in self.isLoading = false })
            .replaceError(with: Array<VideoPostUIModel>())
            .sink(receiveCompletion: { _ in }) {  models in
                print(models.count)
                self.items = models
                
                if models.count > 0 {
                    let vc = self.postUIModelToUIViewControllerMapper.map(from: self.items[0], and: 0)!
                    self.firstViewControllerPublishd = vc
                }
                
            }.store(in: &bag)
        
 
    }
    
    func refresh() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.isLoading = false
            
            
            
            if self.items.count > 0 {
                let vc = self.postUIModelToUIViewControllerMapper.map(from: self.items[0], and: 0)!
                self.firstViewControllerPublishd = vc
            }
            
         
        }
    }
    
    func updateCurrentIndex(for vc: UIViewController?) {
        guard let unwraped = vc, let cast = unwraped as? GenericPostView else { return }
        self.currentIndex = cast.genericPostViewModel.index
    }
    
    func firstViewController() -> UIViewController? {
        postUIModelToUIViewControllerMapper.map(from: items[0], and: 0)
    }
    
    func viewControllerBefore() -> UIViewController? {
        let prevIndex = currentIndex - 1
        guard !isLoading, prevIndex >= 0 else { return nil }
        return postUIModelToUIViewControllerMapper.map(from: items[prevIndex], and: prevIndex)
    }
    
    func viewControllerAfter() -> UIViewController? {
        let nextIndex = currentIndex + 1
        
        if currentIndex >= items.count / 2 {
            print("load more")
            loadNextPage()
        }
        
        guard !isLoading, nextIndex <= items.count - 1 else { return nil }
        
        return postUIModelToUIViewControllerMapper.map(from: items[nextIndex], and: nextIndex)
    }
    
}

private extension VerticalScrollablePageViewModel {
    
    func loadNextPage() {
        debugPrint("loadNextPage")
        currentPage = currentPage + 1
        
        getPostsUseCase.execute(for: currentPage)
            .replaceError(with: PostsModel(posts: Array<PostModel>()))
            .map({ $0.posts.compactMap({ self.postModelToPostUIModelMapper.map(from: $0) }) })
            .sink { models in
                self.items.append(contentsOf: models)
            }
            .store(in: &bag)
    }
}
