//
//  SwipebleVideoPlayer.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import UIKit
import AVFoundation

/// SwipebleVideoPlayer - its a view player to play video content, swipe left or right to seek.
class SwipebleVideoPlayer: UIView {
    
    private var currentItem: AVPlayerItem!
    
    private var player: AVPlayer {
        get {
            return playerLayer.player!
        }
        set {
            playerLayer.player = newValue
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    private var progressBar: ProgressBar = .init()
    
    private var progressUpdateInterval: CMTime {
        .init(value: CMTimeValue(1), timescale: 60)
    }
    
    // pan gesture used for scrubbing
    private let panGesture: UIPanGestureRecognizer = {
        $0.minimumNumberOfTouches = 1
        $0.maximumNumberOfTouches = 1
        $0.cancelsTouchesInView = true
        return $0
    }(UIPanGestureRecognizer())
    
    // time when scrubbing began
    private var scrubbingBeginTime: CMTime?
    
    private var timeObserverToken: Any?
    
    /// Default init method.
    convenience init(asset: AVAsset) {
        self.init(frame: CGRect.zero)
        
        currentItem = .init(asset: asset)
        player = AVPlayer(playerItem: currentItem)
        
        // add progress bar
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressBar)
        
        progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -3).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        // add observer to restart
        NotificationCenter.default.addObserver(self, selector: #selector(restartVideoFromBeginning),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        // add observer to update progress
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: progressUpdateInterval, queue: DispatchQueue.main) {[weak self] (progressTime) in
            self?.updatePlaybackProgress()
        } as AnyObject
        
        //        playerLayer.backgroundColor = UIColor.cyan.cgColor
        panGesture.addTarget(self, action: #selector(didScrub(recognizer:)))
        addGestureRecognizer(panGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            // only allow pan gesture to begin when panning horizontally
            let translation = panGesture.translation(in: self)
            return abs(translation.x) >= 0 && abs(translation.x) > abs(translation.y)
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        player.removeTimeObserver(timeObserverToken as Any)
    }
}

private extension SwipebleVideoPlayer {
    
    func updatePlaybackProgress() {
        
        guard let duration = player.currentItem?.duration.seconds,
              let currentMoment = player.currentItem?.currentTime().seconds, duration != 0, currentMoment > 0.1 else { return }
        
        progressBar.updateProgress(CGFloat(currentMoment / duration))
    }
    
    //function to restart the video
    @objc func restartVideoFromBeginning()  {
        
        progressBar.updateProgress(CGFloat.zero)
        player.seek(to: CMTimeMake(value: 0, timescale: 1))
        player.play()
    }
    
    @objc private func didScrub(recognizer: UIPanGestureRecognizer) {
        guard playerLayer.isReadyForDisplay == true else { return }
        
        switch recognizer.state {
        case .possible:
            // nothing to do here
            break
            
        case .began:
            // pause playback when user begins panning
            player.pause()
            // set time scrubbing began
            scrubbingBeginTime = currentItem.currentTime()
            
        case .changed:
            guard let scrubbingBeginTime = scrubbingBeginTime else {
                return
            }
            let totalSeconds = currentItem.duration.seconds
            // translate point of pan in view
            let point = recognizer.translation(in: self)
            let scrubbingBeginPercent = Double(scrubbingBeginTime.seconds / totalSeconds)
            // calculate percentage of point in view
            var percent = Double(point.x/bounds.width)
            percent += scrubbingBeginPercent
            if percent < 0 {
                percent = 0
            } else if percent > 1.0 {
                percent = 1.0
            }
            // calculate time to seek to in video timeline
            let seconds = Float64(percent * totalSeconds)
            let time = CMTimeMakeWithSeconds(seconds, preferredTimescale: currentItem.duration.timescale)
            player.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            
        case .ended, .cancelled, .failed:
            // reset scrubbing begin time
            scrubbingBeginTime = nil
            // resume playback after user stops panning
            player.play()
            
        @unknown default:
            break
        }
    }
}

extension SwipebleVideoPlayer {
    
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
