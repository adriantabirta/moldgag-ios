//
//  RealVideoCacheService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Combine
import Resolver
import AVFoundation

/// VideoCacheService - service to cache video locally while its playing.
class RealVideoCacheService: NSObject {
    
    // MARK: - Dependencies
    
    @Injected var filenameToLocalPathMapper: FilenameToLocalPathMapper
    
    // MARK: - Proprieties
    
    private var exporter: AVAssetExportSession!
    
    private let queue: DispatchQueue
    
    init(queue: DispatchQueue = .init(label: "com.moldgag.cache-video-queue", qos: .userInitiated)) {
        
        self.queue = queue
        
        super.init()
        
        
       // let s = AVURLAsset.init(url: URL.init(string: "")!)
       // s.resourceLoader.setDelegate(self, queue: DispatchQueue.main)
    }
}

// MARK: - VideoCacheService

extension RealVideoCacheService: VideoCacheService {
    
    
    func cacheAsset(for url: URL) {
        queue.async {
            self.exportSession(forAsset: AVURLAsset(url: url))
        }
    }
    
    func precacheUrls(_ urls: Array<URL>) {
        queue.async {
            urls.map({ AVURLAsset(url: $0) })
                .forEach { asset in
                    self.exportSession(forAsset: asset)
                }
        }
    }
    
    func deleteAllCache() -> AnyPublisher<Void, Never> {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first.publisher
            .compactMap({ $0 })
            .compactMap({
                return try? FileManager.default
                    .contentsOfDirectory(at: $0, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            })
            .handleEvents(receiveOutput: {
                $0.forEach { url in try? FileManager.default.removeItem(at: url) }
            })
            .map({ _ in Void() })
            .eraseToAnyPublisher()
    }

}

// MARK: - AVAssetResourceLoaderDelegate

extension RealVideoCacheService: AVAssetResourceLoaderDelegate {
    
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader,
                        shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        return true
    }
    
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, didCancel loadingRequest: AVAssetResourceLoadingRequest) {
    
    }
}

// MARK: - Private

private extension RealVideoCacheService {
    
    func exportSession(forAsset asset: AVURLAsset) {
        if !asset.isExportable { return }
        
        
        // --- https://stackoverflow.com/a/41545559/1065334
        let composition = AVMutableComposition()
        
        if let compositionVideoTrack = composition.addMutableTrack(withMediaType: AVMediaType.video,
                                                                   preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid)),
           let sourceVideoTrack = asset.tracks(withMediaType: .video).first {
            do {
                try compositionVideoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: asset.duration), of: sourceVideoTrack, at: CMTime.zero)
            } catch {
                print("Failed to compose video")
                return
            }
        }
        
        if let compositionAudioTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio,
                                                                   preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid)),
           let sourceAudioTrack = asset.tracks(withMediaType: .audio).first {
            do {
                try compositionAudioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: asset.duration), of: sourceAudioTrack, at: CMTime.zero)
            } catch {
                print("Failed to compose audio")
                return
            }
        }
        // ---
        
        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
            print("Failed to create export session")
            return
        }
        
        guard let outputURL = filenameToLocalPathMapper.map(from: asset.url.lastPathComponent) else {
            print("Failed to build output url")
            return

        }
                
        // print("File path: \(outputURL)")
        
        if FileManager.default.fileExists(atPath: outputURL.path) {
            do {
                try FileManager.default.removeItem(at: outputURL)
            } catch let error {
                print("Failed to delete file with error: \(error)")
            }
        }
        
        exporter.outputURL = outputURL
        exporter.outputFileType = AVFileType.mp4
        
        //        exporter.determineCompatibleFileTypes { types in
        //            print(types.map({ $0.rawValue }))
        //        }
        
        exporter.exportAsynchronously {
            //            print("Exporter did finish")
            
            if let error = exporter.error {
                print("Error \(error)")
                return
            }
            
            print("video exported with sucess at: \(outputURL)")
        }
        
    }
}
