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
        
        //        if getUserSignInStatusUseCase.isUserSignedIn() {
        //            presentMainScreen()
        //        } else {
        //            presentLoginScreen()
        //        }
        
        
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        //        let vc = LaunchScreenViewController()
        
        //        let vc = UIViewController()
        //        vc.view.backgroundColor = .red
        let root = RootNavigationController(rootViewController: vc)
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = root
        (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
        
        let userSignInStatusUseCase: UserSignInStatusUseCase = Resolver.resolve()

        userSignInStatusUseCase.isUserSignedIn()
            .delay(for: 1, scheduler: DispatchQueue.main)
            .sink { isLoggedIn in
                if isLoggedIn {
                    self.presentMainScreen()
                } else {
                    self.presentLoginScreen()
                }
            }.store(in: &bag)
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
//
//            if userSignInStatusUseCase.isUserSignedIn() {
//                self.presentMainScreen()
//            } else {
//                self.presentLoginScreen()
//            }
//        }
        
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
    
    func presentLoginScreen() {
        
        let vc = SignInView()
        let root = RootNavigationController(rootViewController: vc)
        
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = root
        (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
    }
    
    func presentMainScreen() {
        
        let vc = VerticalScrollablePageView()
        let root = RootNavigationController(rootViewController: vc)
        
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = root
        (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
    }
    
    func presentProfile() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        //        rootViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
