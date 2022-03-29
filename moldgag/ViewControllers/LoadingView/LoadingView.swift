//
//  LoadingView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import UIKit

/// InitialViewController - initial view after splash screen, should display loading and some promotions or statistics
class LoadingView: UIViewController {
    
    private let viewModel: LoadingViewModel
    
    init(_ viewModel: LoadingViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
//        self.view.backgroundColor = .red
        
        view.backgroundColor = .lightGray
        
        let label = UILabel(frame: self.view.frame)
        label.text = "Loading ..."
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        view.addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
