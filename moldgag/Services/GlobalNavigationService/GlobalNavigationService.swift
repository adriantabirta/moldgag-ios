//
//  GlobalNavigationService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.03.2022.
//

import UIKit
import Combine
import Resolver
import MediaPlayer

/// GlobalNavigationService - service to navigate thru app.
class GlobalNavigationService: NSObject, ApplicationService {
    
    // MARK: - Dependencies
    //    @Injected var userSignInStatusUseCase: UserSignInStatusUseCase
    
    // MARK: - Propreties
    
    private var bag = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        debugPrint("\(String(describing: GlobalNavigationService.self)) has started!")
        
        // speed up all app animations
        (UIApplication.shared.delegate as? AppDelegate)?.window?.layer.speed = 1.5
        
        removeSystemVolumeSlider()
        
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
     
        /*
        let rootNavigationController = RootNavigationController()
        let verticalScrollablePageCoordinator = VerticalScrollablePageCoordinator(rootNavigationController)
        verticalScrollablePageCoordinator.start()
    */
        
        let vc = CreateVideoPostView()
        let nc = UINavigationController(rootViewController: vc)
        
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = nc
        (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
    
        return true
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
    
//    func presentLoginScreen() {
//
//        let vc = SignInView()
//        let root = RootNavigationController(rootViewController: vc)
//
//        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = root
//        (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
//    }
//
//    func presentMainScreen() {
//
//        let vc = VerticalScrollablePageView()
//        let root = RootNavigationController(rootViewController: vc)
//
//        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = root
//        (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
//    }
//
//    func presentProfile() {
//        let vc = UIViewController()
//        vc.view.backgroundColor = .red
//        //        rootViewController?.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func presentCreatePost() {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreatePostView")
//        let root = RootNavigationController(rootViewController: vc)
//        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = root
//        (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
//    }
}
