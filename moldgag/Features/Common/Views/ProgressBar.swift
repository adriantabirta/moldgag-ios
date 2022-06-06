//
//  ProgressBar.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import UIKit
import Combine

class ProgressBar: UIView {
    
    var color: UIColor = .white {
        didSet { setNeedsDisplay() }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var progressWithFadeAnimation: CGFloat = 0 {
        didSet {
            self.alpha = 1
            UIView.animate(withDuration: 1.5) {
                self.alpha = 0
                self.progress = self.progressWithFadeAnimation
            }
        }
    }
    
    private let progressLayer = CALayer()
    
    private let backgroundMask = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        layer.addSublayer(progressLayer)
    }
    
    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.5).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        
        progressLayer.frame = progressRect
        progressLayer.backgroundColor = color.cgColor
    }
}
