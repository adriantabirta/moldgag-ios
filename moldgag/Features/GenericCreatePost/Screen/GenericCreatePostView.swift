//
//  GenericCreatePostView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 15.07.2022.
//

import UIKit
import Resolver

class GenericCreatePostView: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: GenericCreatePostViewModel
    
    // MARK: - Propreties
    
    private lazy var titleTextField = UITextField()
    
    private lazy var counterLabel = UILabel()
    
    //    private let bottomConstraint: NSLayoutConstraint
    
    required init(_ viewModel: GenericCreatePostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIViewController

extension GenericCreatePostView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        KeyboardFollower().$keyboardHeight.sink { size in
        //            self.bottomConstraint.constant = size // > 0 ? size + 12 : size
        //            UIView.animate(withDuration: 0.33, animations: { self.view.layoutIfNeeded() })
        //
        //        }
        //        .store(in: &bag)
        //
        //        NotificationCenter.default
        //            .publisher(for: UITextField.textDidChangeNotification, object: titleTextField)
        //            .compactMap({ ($0.object as? UITextField)?.text })
        //            .map({ String("\($0.count)/100") })
        //            .receive(on: RunLoop.main)
        //            .assign(to: \.text, on: counterLabel).store(in: &bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

private extension GenericCreatePostView {
    
    func onBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func onPost() {
        
    }
}
