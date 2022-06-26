//
//  AuthenticationView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 20.02.2022.
//

import UIKit
import Resolver
import AuthenticationServices

class AuthenticationView: UIViewController {
    
    // MARK: - Dependencies
    
    @Injected var viewModel: AuthenticationViewModel
    
    weak var coordinator: AuthenticationCoordinator?
    
    // MARK: - Proprieties
    private let authButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(authButton)
        authButton.addTarget(viewModel, action: #selector(viewModel.signIn), for: UIControl.Event.touchUpInside)
        view.backgroundColor = .random()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        authButton.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.75, height: 50)
        authButton.center = view.center
    }
    
}
