//
//  GlobalNavigationService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.03.2022.
//

import UIKit

/// GlobalNavigationService - service to navigate thru app.
class GlobalNavigationService: NSObject, ApplicationService {
    
    private let rootViewController: UIViewController?
    
    init(rootViewController: UIViewController? = UIApplication.shared.windows.first?.rootViewController) {
        self.rootViewController = rootViewController
        super.init()
        print("GlobalNavigationService has started!")
    
        // speed up all app animations
        (UIApplication.shared.delegate as? AppDelegate)?.window?.layer.speed = 1.5
    }
}

extension GlobalNavigationService {
    
    func presentProfile() {
        let vc = UIViewController()
        rootViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
