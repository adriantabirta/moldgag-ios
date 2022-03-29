//
//  ProgressBar.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import UIKit

class ProgressBar: UIView {
    
    var color: UIColor = .white {
        didSet { setNeedsDisplay() }
    }

   private var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
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

extension ProgressBar {
    
    func updateProgress(_ progress: CGFloat, withFadeOutAnimation: Bool = false) {
        self.alpha = 1
        self.progress = progress
        if withFadeOutAnimation {
            UIView.animate(withDuration: 1.5) {
                self.alpha = 0
            }
        }
    }
}
