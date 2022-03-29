//
//  VideoCacheService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 16.03.2022.
//

import AVFoundation

/// VideoCacheService - service to cache video locally while its playing.
class VideoCacheService: NSObject {
    
    private var exporter: AVAssetExportSession!
    
    private let queue: DispatchQueue
    
    init(queue: DispatchQueue = .init(label: "com.moldgag.cache-video-queue", qos: .background)) {
        
        self.queue = queue
        
        super.init()
        
        
       // let s = AVURLAsset.init(url: URL.init(string: "")!)
       // s.resourceLoader.setDelegate(self, queue: DispatchQueue.main)
    }
    
    func deleteAllCache() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURLs = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        
        fileURLs.forEach { url in
            try! FileManager.default.removeItem(at: url)
        }
        
    }
    
    func preCacheItems(_ items: [Item]) {
        queue.async {
            items.compactMap({ URL(string: $0.url) })
                .map({ AVURLAsset(url: $0) })
                .forEach { asset in
                    self.exportSession(forAsset: asset)
                }
        }
    }
    
    func assetFor(url: URL) -> AVAsset {
        
        let localUrl = buildLocalPathFor(fileName: url.fileName)

        if FileManager.default.fileExists(atPath: localUrl.path) {
            print("run from local cache")
            return AVAsset(url: localUrl)
        } else {
            print("run from network & cache in background")
            
            queue.async {
                self.exportSession(forAsset: AVURLAsset(url: url))
            }
            
            return AVAsset(url: url)
        }
    }
    
    
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
        
        let outputURL = self.buildLocalPathFor(fileName: asset.url.lastPathComponent)
        
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

private extension VideoCacheService {
    
    func buildLocalPathFor(fileName: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent(fileName)
    }
}

extension VideoCacheService: AVAssetResourceLoaderDelegate {
    
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader,
                        shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        return true
    }
    
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, didCancel loadingRequest: AVAssetResourceLoadingRequest) {
    
    }
}

extension URL {
    
    /// filename from url. Example: "https://www.some.com/resource/file_name.mp4" will return "file_name.mp4"
    var fileName: String {
        return self.lastPathComponent
    }
}
