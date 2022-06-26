//
//  VideoRepositoryMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import AVFoundation
@testable import moldgag

class VideoRepositoryMock: VideoRepository {

    var invokedGetVideoAssetFor = false
    var invokedGetVideoAssetForCount = 0
    var invokedGetVideoAssetForParameters: (url: URL, Void)?
    var invokedGetVideoAssetForParametersList = [(url: URL, Void)]()
    var stubbedGetVideoAssetForResult: AVAsset!

    func getVideoAssetFor(_ url: URL) -> AVAsset {
        invokedGetVideoAssetFor = true
        invokedGetVideoAssetForCount += 1
        invokedGetVideoAssetForParameters = (url, ())
        invokedGetVideoAssetForParametersList.append((url, ()))
        return stubbedGetVideoAssetForResult
    }

    var invokedDeleteAll = false
    var invokedDeleteAllCount = 0
    var stubbedDeleteAllResult: AnyPublisher<Void, Never>!

    func deleteAll() -> AnyPublisher<Void, Never> {
        invokedDeleteAll = true
        invokedDeleteAllCount += 1
        return stubbedDeleteAllResult
    }
}
