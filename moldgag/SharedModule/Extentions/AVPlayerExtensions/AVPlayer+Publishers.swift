//
//  AVPlayer+Publishers.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.05.2022.
//

import AVKit
import Combine
import Foundation

public extension AVPlayer {
    
    // MARK: - AVPlayer Publishers
    
    /// Publisher tracking playhead progress updates on `AVPlayer`
    /// - Parameter interval: The interval at which the underlying playhead observer executes an update
    ///
    /// # SeeAlso:
    /// `Publishers.PlayheadProgressPublisher`
    ///
    func playheadProgressPublisher(interval: TimeInterval = 1/60) -> AnyPublisher<TimeInterval, Never> {
        Publishers.PlayheadProgressPublisher(interval: interval, player: self).eraseToAnyPublisher()
    }
    
    /// Wrapper around a `NSObject.KeyValueObservingPublisher` for the `rate` property
    func ratePublisher() -> AnyPublisher<Float, Never> {
        publisher(for: \.rate).eraseToAnyPublisher()
    }
    
    /// Wrapper around a `NSObject.KeyValueObservingPublisher` for the `currentItem` property
    func currentItemPublisher() -> AnyPublisher<AVPlayerItem?, Never> {
        publisher(for: \.currentItem).eraseToAnyPublisher()
    }
}
