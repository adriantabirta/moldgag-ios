//
//  RealVideoRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import Resolver
import AVFoundation

class RealVideoRepository {
    
    // MARK: - Dependencies
    
    @Injected private var videoLocalDataSource: VideoLocalDataSource
    
    // MARK: - Propreties
    
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - VideoRepository

extension RealVideoRepository: VideoRepository {
    
    func getVideoAssetFor(_ url: URL) -> AVAsset {
        if let localAsset = videoLocalDataSource.getVideoAssetFor(url) {
            return localAsset
        }
        
        videoLocalDataSource.saveLocallyVideo(from: url)
//            .receive(on: DispatchQueue.global())
//            .subscribe(on: DispatchQueue.global())
//            .sink(receiveCompletion: { completion in
//                if case let .failure(error) = completion {
//                    print("video not exported: \(error.localizedDescription)")
//                }
//            }, receiveValue: { localUrl in
//                print("video exported with sucess at: \(localUrl)")
//            }).store(in: &cancellables)
        
        return AVAsset(url: url)
    }
    
    func deleteAll() -> AnyPublisher<Void, Never> {
        videoLocalDataSource.deleteAll()
    }
}

