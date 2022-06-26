//
//  VideoRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import Foundation
import AVFoundation

protocol VideoRepository {
    
    func getVideoAssetFor(_ url: URL) -> AVAsset
    
    func deleteAll() -> AnyPublisher<Void, Never>
}
