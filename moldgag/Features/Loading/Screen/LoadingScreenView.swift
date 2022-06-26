//
//  LoadingScreenView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 11.06.2022.
//

import UIKit
import Combine
import Resolver

class LoadingScreenView: UIViewController {
    
    // MARK: - Dependencies

    @Injected private var viewModel: LoadingScreenViewModel

    // MARK: - Propreties
    
    weak var loadingCoordinator: LoadingCoordinator?
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIViewController

extension LoadingScreenView {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.preloadApplicationConent()
            .compactMap({ [weak self] in
                self?.loadingCoordinator
            })
            .flatMap{
                $0.navigateToMain() }
            .sink(receiveValue: {})
            .store(in: &bag)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
}

// MARK: - Private

private extension LoadingScreenView {
    
    func configure() {
        
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "splashimage")
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.tintColor = .white
        activityIndicatorView.color = .white
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 50),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 50),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
