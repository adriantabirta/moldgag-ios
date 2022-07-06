//
//  RealImageRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 06.07.2022.
//

import UIKit
import Combine
import Resolver

struct RealImageRepository {
    
    // MARK: - Dependencies
    
    @Injected private var imageLocalDataSource: ImageLocalDataSource
    
    @Injected private var imageRemoteDataSource: ImageRemoteDataSource
    
    // MARK: - Dependencies
    
    private let placeholder = UIImage(named: "splashimage")!
}

// MARK: - ImageRepository

extension RealImageRepository: ImageRepository {
    
    func getImageFor(_ url: URL) -> AnyPublisher<Optional<UIImage>, Never> {
        if let image = imageLocalDataSource.getImageFor(url) {
            return Just(image).eraseToAnyPublisher()
        } else {
            return imageRemoteDataSource.getImageFor(url)
                .handleEvents(receiveOutput: {
                    guard let image = $0 else { return }
                    self.imageLocalDataSource.save(image, for: url)
                })
                .replaceError(with: placeholder)
                .eraseToAnyPublisher()
        }
    }
    
    func cleanCache() -> AnyPublisher<Void, Never> {
        Just(imageLocalDataSource.cleanCache()).eraseToAnyPublisher()
    }
}
