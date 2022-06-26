//
//  AuthenticationCoordinator.swift
//  moldgag
//
//  Created by Adrian Tabirta on 11.06.2022.
//

import UIKit

class AuthenticationCoordinator: Coordinator {
    
    var childCoordinators: Array<Coordinator>
    
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.childCoordinators = .init()
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = AuthenticationView()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func navigateToMain() {
        let coord = VerticalScrollablePageCoordinator(navigationController)
        coord.start()
    }
}
