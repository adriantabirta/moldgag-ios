//
//  SwipebleVideoPlayerView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import UIKit
import Combine
import Resolver
import AVFoundation

class ScrubbingPanGestureRecognizer: UIPanGestureRecognizer {
    
    override var minimumNumberOfTouches: Int {
        get{ 1 }
        set{}
    }
    
    override var maximumNumberOfTouches: Int {
        get{ 1 }
        set{}
    }
    
    override var cancelsTouchesInView: Bool {
        get{ true }
        set{}
    }
}

/// SwipebleVideoPlayer - its a view player to play video content, swipe left or right to seek.
class SwipebleVideoPlayerView: UIView {
    
    // MARK: - Dependencies
    
    var viewModel: SwipebleVideoPlayerViewModel
    
    var playerLayer: AVPlayerLayer
    
    private var progressBar: ProgressBar = .init()
    
    private let panGesture = ScrubbingPanGestureRecognizer()
    
    private let generator = UISelectionFeedbackGenerator()

    
    // time when scrubbing began
    private var scrubbingBeginTime: CMTime?
    
    private var timeObserverToken: Any?
    
    private var bag = Set<AnyCancellable>()
   
    init(viewModel: SwipebleVideoPlayerViewModel) {
        self.viewModel = viewModel
        self.playerLayer = AVPlayerLayer(player: viewModel.player)
        super.init(frame: UIScreen.main.bounds)
        
        playerLayer.frame = self.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        layer.addSublayer(playerLayer)
        
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressBar)
        
        progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -3).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        viewModel.$progress.receive(on: RunLoop.main).assign(to: \.progress, on: progressBar).store(in: &bag)
        
        generator.prepare()
     
        // todo: move scrub into separate file 
        panGesture.addTarget(self, action: #selector(didScrub(recognizer:)))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            // only allow pan gesture to begin when panning horizontally
            let translation = panGesture.translation(in: self)
            return abs(translation.x) >= 0 && abs(translation.x) > abs(translation.y)
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
}

private extension SwipebleVideoPlayerView {
    
    @objc private func didScrub(recognizer: UIPanGestureRecognizer) {
        guard playerLayer.isReadyForDisplay == true else { return }
        
        switch recognizer.state {
        case .possible:
            // nothing to do here
            break
            
        case .began:
            // pause playback when user begins panning
            viewModel.pause()
            // set time scrubbing began
            scrubbingBeginTime = viewModel.currentItem.currentTime()
            
            generator.selectionChanged()
            
        case .changed:
            guard let scrubbingBeginTime = scrubbingBeginTime else {
                return
            }
            let totalSeconds = viewModel.currentItem.duration.seconds
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
            let time = CMTimeMakeWithSeconds(seconds, preferredTimescale: viewModel.currentItem.duration.timescale)
            viewModel.player.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            
//            generator.selectionChanged()

            
        case .ended, .cancelled, .failed:
            // reset scrubbing begin time
            scrubbingBeginTime = nil
            // resume playback after user stops panning
            viewModel.play()
            
            generator.selectionChanged()
            
        @unknown default:
            break
        }
    }
}

extension SwipebleVideoPlayerView {
    
    func play() {
        viewModel.play()
    }
    
    func pause()  {
        viewModel.pause()
    }
    
    func toggle() {
        viewModel.toggle()
    }
}
