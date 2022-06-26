//
//  GetVideoAssetUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import AVFoundation

protocol GetVideoAssetUseCase {
    
    func execute(for url: URL) -> AVAsset
    
}
