//
//  VideoCacheService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 16.03.2022.
//

import Foundation

protocol VideoCacheService {
    
    func cacheAsset(for url: URL)
    
    func precacheUrls(_ urls: Array<URL>)
    
    func deleteAllCache()
    
}
