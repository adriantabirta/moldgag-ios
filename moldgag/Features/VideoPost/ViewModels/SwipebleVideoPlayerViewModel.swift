//
//  SwipebleVideoPlayerViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.05.2022.
//

import Combine
import AVFoundation

class SwipebleVideoPlayerViewModel: ObservableObject {
    
    @Published var currentItem: AVPlayerItem
    
    @Published var progress: CGFloat = .zero
    
    @Published var player: AVPlayer
    
    private let progressUpdateInterval = CMTime(value: CMTimeValue(1), timescale: 60)
    
    private var bag = Set<AnyCancellable>()
    
    init(asset: AVAsset) {
        let item = AVPlayerItem(asset: asset)
        self.currentItem = item
        self.player = AVPlayer(playerItem: item)
        
        player.currentItem?.didPlayToEndTimePublisher()
            .handleEvents(receiveOutput: { _ in self.progress = CGFloat.zero })
            .handleEvents(receiveOutput: { _ in self.player.seek(to: CMTimeMake(value: 0, timescale: 1)) })
            .handleEvents(receiveOutput: { _ in self.player.play() })
            .sink(receiveValue: { _ in }).store(in: &bag)


       player.playheadProgressPublisher()
            .compactMap({ _ -> CGFloat? in
                guard let duration = self.player.currentItem?.duration.seconds,
                      let currentMoment = self.player.currentItem?.currentTime().seconds, duration != 0, currentMoment > 0.1 else { return nil }
                return CGFloat(currentMoment / duration)
            })
            .assign(to: \.progress, on: self).store(in: &bag)
        
    
        
     
        //        playerLayer.backgroundColor = UIColor.cyan.cgColor
//        panGesture.addTarget(self, action: #selector(didScrub(recognizer:)))
//        addGestureRecognizer(panGesture)
    }
}


extension SwipebleVideoPlayerViewModel {
    
    func play() {
        player.play()
    }
    
    func pause()  {
        player.pause()
    }
    
    func toggle() {
        player.timeControlStatus == .playing ? player.pause() : player.play()
    }
}
