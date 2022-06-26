//
//  ImageCacheServiceMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import UIKit
import Combine
import AVFoundation
@testable import moldgag

class ImageCacheServiceMock: ImageCacheService {
    
    var invokedCacheImage = false
    var invokedCacheImageCount = 0
    var invokedCacheImageParameters: (url: URL, Void)?
    var invokedCacheImageParametersList = [(url: URL, Void)]()
    var stubbedCacheImageResult: AnyPublisher<Optional<UIImage>, Never>!
    
    func cacheImage(for url: URL) -> AnyPublisher<Optional<UIImage>, Never> {
        invokedCacheImage = true
        invokedCacheImageCount += 1
        invokedCacheImageParameters = (url, ())
        invokedCacheImageParametersList.append((url, ()))
        return stubbedCacheImageResult
    }
    
    var invokedDeleteAllCache = false
    var invokedDeleteAllCacheCount = 0
    var stubbedDeleteAllCacheResult: AnyPublisher<Void, Never>!
    
    func deleteAllCache() -> AnyPublisher<Void, Never> {
        invokedDeleteAllCache = true
        invokedDeleteAllCacheCount += 1
        return stubbedDeleteAllCacheResult
    }
}
