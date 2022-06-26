//
//  LoadingCoordinator.swift
//  moldgag
//
//  Created by Adrian Tabirta on 11.06.2022.
//

import UIKit
import Combine

class LoadingCoordinator: Coordinator {
    
    var childCoordinators: Array<Coordinator>
    
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.childCoordinators = .init()
        self.navigationController = navigationController
    }
    
    func start() {
        let loadingScreenView = LoadingScreenView()
        navigationController.setViewControllers([loadingScreenView], animated: true)
        loadingScreenView.loadingCoordinator = self
    }
    
    func navigateToMain() -> AnyPublisher<Void, Never> {
        let verticalScrollablePageCoordinator = VerticalScrollablePageCoordinator(navigationController)
        return Future { (promise) in
            verticalScrollablePageCoordinator.start()
            promise(.success(()))
        }.eraseToAnyPublisher()
        
    }
    
}
