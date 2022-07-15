//
//  NextButton.swift
//  moldgag
//
//  Created by Adrian Tabirta on 15.07.2022.
//

import UIKit

class NextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

private extension NextButton {
    
    func configure() {
        self.setTitle("Next", for: .normal)
        self.setTitleColor(UIColor.gray, for: .normal)
        self.backgroundColor = .offWhite
    }
    
    
    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height * 0.25
        self.layer.masksToBounds = true
    }
}
