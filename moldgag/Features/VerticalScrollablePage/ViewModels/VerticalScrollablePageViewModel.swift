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
    
    @Injected var loadPostsForPageUseCase: LoadPostsForPageUseCase
    
    @Injected var refreshPostsUseCase: RefreshPostsUseCase
    
    @Injected var getPostsUseCase: GetPostsStreamUseCase
    
    @Injected var postModelToPostUIModelMapper: PostModelToPostUIModelMapper
    
    @Injected var postUIModelToUIViewControllerMapper: PostUIModelToUIViewControllerMapper
    
    
    // MARK: - Proprieties
    
    @Published var verticalScrollablePageUIModel: VerticalScrollablePageUIModel
    
    private var items: Array<VideoPostUIModel> = .init()
    
    @Published var firstViewControllerPublished: UIViewController = .init()
    
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
        
        self.firstViewControllerPublished = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        
        refresh()
        
        let onNewPosts = getPostsUseCase.execute()
        
        onNewPosts
            .map({ self.postModelToPostUIModelMapper.map(from: $0) })
            .sink { newPosts in
                self.items = newPosts
            }.store(in: &bag)
        
        
        onNewPosts.delay(for: 0.5, scheduler: RunLoop.main)
            .filter {
                $0.count > 0 && $0.count <= 10 }
            .compactMap { _ in self.firstViewController() }
            .sink(receiveValue: { vc in
                //            guard models.count > 0, let vc = self.firstViewController() else { return }
                self.firstViewControllerPublished = vc
            }).store(in: &bag)
        
        //        $items.sink { models in
        //            guard models.count == 0, let vc = self.firstViewController() else { return }
        //            self.firstViewControllerPublished = vc
        //        }
        
        // refresh() -> getPostsUseCase.execute() -> assign to items -> set first page
        
        // todo: move up and load only first 3 elements
        // todo: make here request to get new data
        // videoCacheService.preCacheItems(items)
    }
}

extension VerticalScrollablePageViewModel {
    
    func loadFirstPage() {
        print(#function)
        isLoading = true
        loadPostsForPageUseCase.execute(for: 0).sink(receiveValue: { self.isLoading = false }).store(in: &bag)
    }
    
    func refresh() {
        print(#function)
        isLoading = true
        refreshPostsUseCase.execute().sink(receiveValue: { self.isLoading = false }).store(in: &bag)
    }
    
    func updateCurrentIndex(for vc: UIViewController?) {
        guard let unwraped = vc, let cast = unwraped as? GenericPostView else { return }
        self.currentIndex = cast.genericPostViewModel.index
    }
    
    func firstViewController() -> UIViewController? {
        guard items.indices.contains(0) else { return nil }
        return postUIModelToUIViewControllerMapper.map(from: items[0], and: 0) ?? UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
    }
    
    func viewControllerBefore() -> UIViewController? {
        let prevIndex = currentIndex - 1
        guard !isLoading, prevIndex >= 0 else { return nil }
        return postUIModelToUIViewControllerMapper.map(from: items[prevIndex], and: prevIndex)
    }
    
    func viewControllerAfter() -> UIViewController? {
        let nextIndex = currentIndex + 1
        
        if currentIndex >= items.count / 2 {
            loadNextPage()
        }
        
        guard !isLoading, nextIndex <= items.count - 1 else { return nil }
        
        return postUIModelToUIViewControllerMapper.map(from: items[nextIndex], and: nextIndex)
    }
    
}

private extension VerticalScrollablePageViewModel {
    
    func loadNextPage() {
        print(#function)
        currentPage = currentPage + 1
        loadPostsForPageUseCase.execute(for: currentPage)
            .receive(on: DispatchQueue.global())
            .subscribe(on: DispatchQueue.global())
            .sink(receiveValue: {}).store(in: &bag)
    }
}
