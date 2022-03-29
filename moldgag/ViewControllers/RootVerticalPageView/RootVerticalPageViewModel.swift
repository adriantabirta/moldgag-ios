//
//  RootVerticalPageViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import UIKit
import Foundation

/// RootVerticalPageViewModel - 
class RootVerticalPageViewModel {
    
    var currentIndex: Int {
        didSet {
            print("current index \(currentIndex)")
        }
    }

    var currentPage: Int
    
    var items: [Item]
    
    private let videoCacheService: VideoCacheService
    
    private let moldgagVideoService: MoldgagVideoService
    
    private var onReadyForUpdateUI: (UIViewController) -> Void = { _ in }
    
    var isLoading: Bool
    
    init(currentIndex: Int = 0,
         currentPage: Int = 0,
         items: [Item] = [],
         isLoading: Bool = false,
         videoCacheService: VideoCacheService = .init(),
         moldgagVideoService: MoldgagVideoService) {
        
        self.currentIndex = currentIndex
        self.currentPage = currentPage
        self.items = items
        self.isLoading = isLoading
        self.videoCacheService = videoCacheService
        self.moldgagVideoService = moldgagVideoService
 
        
//        self.onFirstVCReady(self.viewControllers[0])
        
        // todo: move up and load only first 3 elements
        // todo: make here request to get new data
        // videoCacheService.preCacheItems(items)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.items = self.moldgagVideoService.items(for: 0)
            
            let vc = self.buildViewController(for: self.items[0], index: 0)
            
            self.onReadyForUpdateUI(vc!)
        }
    }
}

extension RootVerticalPageViewModel {
    
    func refresh() {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.isLoading = false

            self.items = self.items.shuffled()
            
            let vc = self.buildViewController(for: self.items[0], index: 0)
            
            self.onReadyForUpdateUI(vc!)
        
        }
    }
    
    func updateCurrentIndex(for vc: UIViewController?) {
        guard let unwraped = vc, let cast = unwraped as? GenericItemViewController else { return }
        self.currentIndex = cast.index
    }
    
    func viewControllerBefore() -> UIViewController? {
        let prevIndex = currentIndex - 1
        guard !isLoading, prevIndex >= 0 else { return nil }
        return buildViewController(for: items[prevIndex], index: prevIndex)
    }
    
    func viewControllerAfter() -> UIViewController? {        
        let nextIndex = currentIndex + 1
        
        if currentIndex >= items.count / 2 {
            print("load more")
            loadNextPage()
        }
        
        guard !isLoading, nextIndex <= items.count - 1 else { return nil }
        
        return buildViewController(for: items[nextIndex], index: nextIndex)
    }
    
    func updateViewController(_ closure: @escaping (UIViewController) -> Void) {
        self.onReadyForUpdateUI = closure
    }
}

private extension RootVerticalPageViewModel {
    
    func loadNextPage() {
        currentPage = currentPage + 1
        items.append(contentsOf:  moldgagVideoService.items(for: currentPage))
    }
    
    func buildViewController(for item: Item, index: Int) -> UIViewController? {
        switch item.type {
        case .video:
            if let vm = VideoItemViewModel(item: item) {
                return VideoItemView.init(vm, index: index)//(vm)
            }
            return nil
            
        case .image:
            return ImageItemView(.init(item: item), index: index)
            
        case .adBanner:
            return AdvertisingItemView(.init(item: item), index: index)
            
        }
    }
}


