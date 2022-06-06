//
//  VideoCacheServiceMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import AVFoundation

class VideoCacheServiceMock: VideoCacheService {

    var invokedCacheAsset = false
    var invokedCacheAssetCount = 0
    var invokedCacheAssetParameters: (url: URL, Void)?
    var invokedCacheAssetParametersList = [(url: URL, Void)]()

    func cacheAsset(for url: URL) {
        invokedCacheAsset = true
        invokedCacheAssetCount += 1
        invokedCacheAssetParameters = (url, ())
        invokedCacheAssetParametersList.append((url, ()))
    }

    var invokedPrecacheUrls = false
    var invokedPrecacheUrlsCount = 0
    var invokedPrecacheUrlsParameters: (urls: Array<URL>, Void)?
    var invokedPrecacheUrlsParametersList = [(urls: Array<URL>, Void)]()

    func precacheUrls(_ urls: Array<URL>) {
        invokedPrecacheUrls = true
        invokedPrecacheUrlsCount += 1
        invokedPrecacheUrlsParameters = (urls, ())
        invokedPrecacheUrlsParametersList.append((urls, ()))
    }

    var invokedDeleteAllCache = false
    var invokedDeleteAllCacheCount = 0

    func deleteAllCache() {
        invokedDeleteAllCache = true
        invokedDeleteAllCacheCount += 1
    }
}
