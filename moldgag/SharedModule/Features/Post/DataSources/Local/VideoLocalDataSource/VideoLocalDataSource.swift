//
//  VideoLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import AVFoundation

protocol VideoLocalDataSource {
    
    func getVideoAssetFor(_ url: URL) -> AVAsset?
    
    func saveVideoAsset(from remoteUrl: URL) -> AnyPublisher<URL, ApplicationError>
    
    func deleteAll() -> AnyPublisher<Void, Never>
    
}
