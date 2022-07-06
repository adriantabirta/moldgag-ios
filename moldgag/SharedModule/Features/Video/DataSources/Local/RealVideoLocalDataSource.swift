//
//  RealVideoLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import Resolver
import AVFoundation

struct RealVideoLocalDataSource {
    
    // MARK: - Dependencies
    
    @Injected var filenameToLocalPathMapper: FilenameToLocalPathMapper
    
    // MARK: - Propreties
    
    private let queue = DispatchQueue.global(qos: .utility)
    
}

// MARK: - VideoLocalDataSource

extension RealVideoLocalDataSource: VideoLocalDataSource {
    
    func getVideoAssetFor(_ url: URL) -> AVAsset? {
        guard let localPath = filenameToLocalPathMapper.map(from: url.fileName),
              FileManager.default.fileExists(atPath: localPath.path) else { return nil }
        return AVAsset(url: localPath)
    }
    
    func saveLocallyVideo(from remoteUrl: URL) {
        queue.async {
            let asset = AVURLAsset(url: remoteUrl)
            
            if !asset.isExportable {
                ApplicationError.filesystem(.fileCannotBeExported).handle()
                return
            }
            
            switch createFileComposition(from: asset) {
            case let .success(composition):
                
                guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
                    ApplicationError.filesystem(.cannotCreateExportSession).handle()
                    return
                }
                
                guard let outputURL = filenameToLocalPathMapper.map(from: asset.url.lastPathComponent) else {
                    ApplicationError.filesystem(.cannotCreateLocalUrl).handle()
                    return
                }
                
                deleteLocalFileIfExists(for: outputURL)
                
                exporter.outputURL = outputURL
                exporter.outputFileType = AVFileType.mp4
                
                exporter.exportAsynchronously {
                    
                    if let error = exporter.error {
                        ApplicationError.filesystem(.exporter(error)).handle()
                        return
                    }
                    
                    print("video exported with success: \(outputURL)")
                }
                
            case let .failure(applicationError):
                applicationError.handle()
            }
        }
    }
    
    func deleteAll() -> AnyPublisher<Void, Never> {
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

private extension RealVideoLocalDataSource {
    
    func createFileComposition(from asset: AVAsset) -> Result<AVComposition, ApplicationError> {
        let composition = AVMutableComposition()
        
        if let compositionVideoTrack = composition.addMutableTrack(withMediaType: AVMediaType.video,
                                                                   preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid)),
           let sourceVideoTrack = asset.tracks(withMediaType: .video).first {
            do {
                try compositionVideoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: asset.duration), of: sourceVideoTrack, at: CMTime.zero)
            } catch {
                return Result.failure(ApplicationError.filesystem(.cannotComposeVideoFileOnExport))
            }
        }
        
        if let compositionAudioTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio,
                                                                   preferredTrackID: CMPersistentTrackID(kCMPersistentTrackID_Invalid)),
           let sourceAudioTrack = asset.tracks(withMediaType: .audio).first {
            do {
                try compositionAudioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: asset.duration), of: sourceAudioTrack, at: CMTime.zero)
            } catch {
                return Result.failure(ApplicationError.filesystem(.cannotComposeAudioFileOnExport))
            }
        }
        
        return .success(composition)
    }
    
    func deleteLocalFileIfExists(for url: URL) {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch let error {
                print("Failed to delete file with error: \(error)")
            }
        }
    }
}
