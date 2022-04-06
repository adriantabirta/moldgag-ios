//
//  GlobalNavigationService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.03.2022.
//

import UIKit
import MediaPlayer

/// GlobalNavigationService - service to navigate thru app.
class GlobalNavigationService: NSObject, ApplicationService {
    
    private let rootViewController: UIViewController?
    
    init(rootViewController: UIViewController? = UIApplication.shared.windows.first?.rootViewController) {
        self.rootViewController = rootViewController
        super.init()
        print("GlobalNavigationService has started!")
    
        // speed up all app animations
        (UIApplication.shared.delegate as? AppDelegate)?.window?.layer.speed = 1.5
        
        removeSystemVolumeSlider()
    }
}

private extension GlobalNavigationService {
    
    func removeSystemVolumeSlider() {
        let volumeView = MPVolumeView(frame: CGRect.zero)
        
        for subview in volumeView.subviews {
            if let button = subview as? UIButton {
                button.setImage(nil, for: .normal)
                button.isEnabled = false
                button.sizeToFit()
            }
        }
        
        UIApplication.shared.windows.first?.addSubview(volumeView)
        UIApplication.shared.windows.first?.sendSubviewToBack(volumeView)
    }
}

extension GlobalNavigationService {
    
    func presentProfile() {
        let vc = UIViewController()
        rootViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
