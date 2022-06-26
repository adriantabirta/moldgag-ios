//
//  VerticalScrollablePageCoordinator.swift
//  moldgag
//
//  Created by Adrian Tabirta on 11.06.2022.
//

import UIKit

class VerticalScrollablePageCoordinator: Coordinator {
    
    var childCoordinators: Array<Coordinator>
    
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.childCoordinators = .init()
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = VerticalScrollablePageView()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
}
