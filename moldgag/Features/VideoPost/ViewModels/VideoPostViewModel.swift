//
//  VideoPostViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import Combine
import Resolver
import Foundation
import AVFoundation

class VideoPostViewModel {
    
    // MARK: - Dependencies
    
    @Injected var getVideoPostUseCase: GetVideoAssetUseCase
    
    // MARK: - Properties
    
    let postUIModel: VideoPostUIModel
    
    var asset: AVAsset {
        getVideoPostUseCase.execute(for: postUIModel.url)
    }
        
    init(postUIModel: VideoPostUIModel) {
        self.postUIModel = postUIModel
    }
    
}
