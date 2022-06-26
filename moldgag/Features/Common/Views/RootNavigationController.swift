//
//  RootNavigationController.swift
//  moldgag
//
//  Created by Adrian Tabirta on 20.02.2022.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setNavigationBarHidden(true, animated: false)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
