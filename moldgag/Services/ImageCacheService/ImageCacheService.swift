//
//  ImageCacheService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import UIKit
import Combine

protocol ImageCacheService {
    
    func cacheImage(for url: URL) -> AnyPublisher<Optional<UIImage>, Never>
    
}
