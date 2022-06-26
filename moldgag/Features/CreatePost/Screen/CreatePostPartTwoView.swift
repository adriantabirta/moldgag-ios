//
//  CreatePostPart2View.swift
//  moldgag
//
//  Created by Adrian Tabirta on 07.06.2022.
//

import UIKit
import Combine
import Resolver

class CreatePostPartTwoView: UIViewController {
    
    // MARK: - Dependencies
    
    let viewModel: CreatePostPartTwoViewModel
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Propreties
    
    private var bag = Set<AnyCancellable>()
    
    init(_ viewModel: CreatePostPartTwoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UIViewController

extension CreatePostPartTwoView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardFollower().$keyboardHeight.sink { size in
            self.bottomConstraint.constant = size // > 0 ? size + 12 : size
            UIView.animate(withDuration: 0.33, animations: { self.view.layoutIfNeeded() })
            
        }
        .store(in: &bag)
        
        NotificationCenter.default
                   .publisher(for: UITextField.textDidChangeNotification, object: titleTextField)
                   .compactMap({ ($0.object as? UITextField)?.text })
                   .map({ String("\($0.count)/100") })
                   .receive(on: RunLoop.main)
                   .assign(to: \.text, on: counterLabel).store(in: &bag)
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

// MARK: - IBActions

extension CreatePostPartTwoView {
    
    @IBAction func onBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onPost() {
        viewModel.createPost(with: titleTextField.text)
    }
}
