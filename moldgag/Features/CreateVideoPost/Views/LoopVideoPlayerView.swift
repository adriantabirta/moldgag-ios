//
//  LoopVideoPlayerView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 07.07.2022.
//

import UIKit
import AVFoundation

// todo: delete it
class LoopVideoPlayerView: UIView {
    
    private var playerLooper: AVPlayerLooper
    
    private lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: queuePlayer)
        layer.player = queuePlayer
        layer.videoGravity = .resizeAspectFill
        layer.backgroundColor = UIColor.black.cgColor
        return layer
    }()
    
    private var queuePlayer: AVQueuePlayer!
    
    init(_ url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        self.queuePlayer = AVQueuePlayer(playerItem: playerItem)
        self.playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        super.init(frame: .zero)
        
        layer.addSublayer(AVPlayerLayer(player: queuePlayer))
        self.queuePlayer.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = self.frame
    }
}
