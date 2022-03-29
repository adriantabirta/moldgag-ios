//
//  VideoItemViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import Foundation
import AVFoundation

class VideoItemViewModel {
    
    let item: Item
    
    private let videoURL: URL
    
    private let videoCacheService: VideoCacheService
    
    init?(item: Item, videoCacheService: VideoCacheService = .init()) {
        guard let videoURL = URL(string: item.url) else { return nil }
        self.item = item
        self.videoURL = videoURL
        self.videoCacheService = videoCacheService
    }
    
    var asset: AVAsset {
        videoCacheService.assetFor(url: videoURL)
    }
}


