//
//  Coordinator.swift
//  moldgag
//
//  Created by Adrian Tabirta on 11.06.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: Array<Coordinator> { get set }
    
    var navigationController: UINavigationController { get set }
    
    func start()
}
