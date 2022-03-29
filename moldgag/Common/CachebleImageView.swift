//
//  CachebleImageView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 23.03.2022.
//

import UIKit

/// CachebleImageView - 
class CachebleImageView: UIImageView {
    
    init?(url: String) {
        guard let url = URL(string: url) else { return nil }
        super.init(frame: CGRect.zero)
        self.load(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
