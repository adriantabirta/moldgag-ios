//
//  CreatePhotoPostCoordinator.swift
//  moldgag
//
//  Created by Adrian Tabirta on 15.07.2022.
//

import UIKit

class CreatePhotoPostCoordinator: Coordinator {
    
    var childCoordinators: Array<Coordinator>
    
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.childCoordinators = .init()
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CreatePhotoPostView()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func navigateToNextScreen(_ url: URL) {
        let vc = GenericCreatePostView(.init(mediaUrl: url, postType: .image))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        
    }
}
