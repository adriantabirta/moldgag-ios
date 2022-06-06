//
//  RealGetVideoPostUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Resolver
import AVFoundation

class RealGetVideoPostUseCase: GetVideoPostUseCase {
    
    // MARK: - Dependencies
    
    @Injected var videoCacheService: VideoCacheService
    
    @Injected var filenameToLocalPathMapper: FilenameToLocalPathMapper
    
}

// MARK: - GetVideoPostUseCase

extension RealGetVideoPostUseCase {
    
    func execute(for url: URL) -> AVAsset {
        if let localPath = filenameToLocalPathMapper.map(from: url.fileName),
           FileManager.default.fileExists(atPath: localPath.path)  {
            
            debugPrint("run from local cache")

            return AVAsset(url: localPath)
        } else {
            
            debugPrint("run from network & cache in background")

            videoCacheService.cacheAsset(for: url)
            
            return AVAsset(url: url)
        }
    }
    
}
