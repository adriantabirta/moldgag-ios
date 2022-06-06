//
//  AVPlayerItem+Publishers.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.05.2022.
//

import AVKit
import Combine
import Foundation

public extension AVPlayerItem {
    
    /// Wrapper around a `NSObject.KeyValueObservingPublisher` for the `isPlaybackLikelyToKeepUp` property
    func isPlaybackLikelyToKeepUpPublisher() -> AnyPublisher<Bool, Never> {
        publisher(for: \.isPlaybackLikelyToKeepUp).eraseToAnyPublisher()
    }
    
    /// Wrapper around a `NSObject.KeyValueObservingPublisher` for the `isPlaybackBufferEmpty` property
    func isPlaybackBufferEmptyPublisher() -> AnyPublisher<Bool, Never> {
        publisher(for: \.isPlaybackBufferEmpty).eraseToAnyPublisher()
    }
    
    /// Wrapper around a `NSObject.KeyValueObservingPublisher` for the `status` property
    func statusPublisher() -> AnyPublisher<AVPlayerItem.Status, Never> {
        publisher(for: \.status).eraseToAnyPublisher()
    }
    
    /// Wrapper around a `NSObject.KeyValueObservingPublisher` for the `duration` property
    func durationPublisher() -> AnyPublisher<CMTime, Never> {
        publisher(for: \.duration).eraseToAnyPublisher()
    }
    
    /// Wrapper around a `NotificationCenter.Publisher` that emits values for `.AVPlayerItemDidPlayToEndTime`
    func didPlayToEndTimePublisher(_ notificationCenter: NotificationCenter = .default) -> AnyPublisher<Notification, Never> {
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime, object: self).eraseToAnyPublisher()
    }
}
