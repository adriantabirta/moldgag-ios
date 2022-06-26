//
//  AudioSessionVolumeMonitor.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Combine
import AVFoundation
import CoreGraphics

class AudioSessionVolumeMonitor {

    var volume: AnyPublisher<CGFloat, Never> {
        AVAudioSession.sharedInstance().publisher(for: \.outputVolume)
            .map({ CGFloat($0) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
