//
//  SignInViewController.swift
//  moldgag
//
//  Created by Adrian Tabirta on 20.02.2022.
//

import UIKit
import AuthenticationServices

class SignInViewController: UIViewController {

    private let authButton = ASAuthorizationAppleIDButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(authButton)
        authButton.addTarget(self, action: #selector(didTapSignIn), for: UIControl.Event.touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        authButton.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.75, height: 50)
        authButton.center = view.center
        
    }
    
    @objc func didTapSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            print(credentials.fullName?.givenName)
            print(credentials.fullName?.familyName)
            print(credentials.email)
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNavigationController")
         
         
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = vc
            (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()

            break
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
   
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
