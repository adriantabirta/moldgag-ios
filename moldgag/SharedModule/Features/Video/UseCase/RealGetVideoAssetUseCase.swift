//
//  RealGetVideoPostUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Resolver
import AVFoundation

class RealGetVideoAssetUseCase {
    
    // MARK: - Dependencies
    
    @Injected var videoRepository: VideoRepository
    
}

// MARK: - GetVideoPostUseCase

extension RealGetVideoAssetUseCase: GetVideoAssetUseCase {
    
    func execute(for url: URL) -> AVAsset {
        videoRepository.getVideoAssetFor(url)
    }
}
