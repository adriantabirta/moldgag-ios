//
//  RealImageRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 06.07.2022.
//

import UIKit
import Combine
import Resolver

struct RealImageRemoteDataSource {
    
    // MARK: - Dependencies
    
    @Injected private var networkServiceProvider: NetworkServiceProvider<PostNetworkService>
    
    // MARK: - Proprieties
    
    private var bag = Set<AnyCancellable>()
    
}

extension RealImageRemoteDataSource: ImageRemoteDataSource {
    
    func getImageFor(_ url: URL) -> AnyPublisher<Optional<UIImage>, Never> {
        networkServiceProvider.dataRequest(url)
            .compactMap { $0 }
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
