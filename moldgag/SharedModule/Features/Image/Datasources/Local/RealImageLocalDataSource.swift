//
//  RealImageLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 06.07.2022.
//

import UIKit

struct RealImageLocalDataSource {
    
    // MARK: - Properties
    
    private let cache: NSCache<NSString, UIImage>
    
    private let totalCostLimit = 50 * 1024 * 1024 // (50 MB)
    
    init() {
        self.cache = .init()
        self.cache.totalCostLimit = totalCostLimit
    }
    
}

// MARK: - ImageLocalDataSource

extension RealImageLocalDataSource: ImageLocalDataSource {
    
    func getImageFor(_ url: URL) -> Optional<UIImage> {
        cache.object(forKey: NSString(string: url.absoluteString))
    }
    
    func save(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: NSString(string: url.absoluteString))
    }
    
    func cleanCache() {
        cache.removeAllObjects()
    }
}
