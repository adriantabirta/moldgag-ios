//
//  RealImageCacheService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import UIKit
import Combine

class RealImageCacheService {
    
    // MARK: - Proprieties
    
    private let cache: URLCache
    
    private let placeholder: Optional<UIImage>
    
    init(cache: URLCache = .shared, placeholder: Optional<UIImage> = .init(systemName: "photo")) {
        self.cache = cache
        self.placeholder = placeholder
    }
    
}

// MARK: - ImageCacheService

extension RealImageCacheService: ImageCacheService {
    
    func cacheImage(for url: URL) -> AnyPublisher<Optional<UIImage>, Never> {
        let request = URLRequest(url: url)
        
        if let cachedImageData = cache.cachedResponse(for: request)?.data {
            return Just(cachedImageData)
                .compactMap({ UIImage(data: $0) })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } else {
            return URLSession.shared.dataTaskPublisher(for: request)
                .map({ (data, response) -> Optional<UIImage> in
                    guard ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300 else { return nil }
                    return UIImage(data: data) ?? self.placeholder
                })
                .mapError({ error -> Error in
                    ApplicationError(error).handle()
                    return error })
                .replaceError(with: UIImage())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}
