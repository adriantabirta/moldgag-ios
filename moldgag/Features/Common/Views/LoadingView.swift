//
//  LoadingView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import UIKit

/// InitialViewController - initial view after splash screen, should display loading and some promotions or statistics
class LoadingView: UIViewController {
    
    private lazy var loadingLabel: UILabel = {
        $0.text = "Loading ..."
        $0.font = .systemFont(ofSize: 25, weight: .bold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel(frame: self.view.frame))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .lightGray
        view.addSubview(loadingLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
