//
//  CreateVideoPostView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 14.07.2022.
//

import UIKit
import Combine
import Resolver

class CreateVideoPostView: UIViewController {
    
    // MARK: - Dependencies
    
    @Injected var viewModel: CreateVideoPostViewModel
    

    // MARK: - Properties
    
    weak var coordinator: CreateVideoPostCoordinator?
    
    private lazy var genericVideoPicker = GenericVideoPicker()
    
    private lazy var videoView = LoopVideoView()
    
    private lazy var infoLabel = UILabel()
    
    private lazy var nextButton = NextButton()
    
    private var bag = Set<AnyCancellable>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = .white
        _ = genericVideoPicker.view
        genericVideoPicker.onPick { info in
            self.viewModel.configure(with: info)
            self.videoView.url = self.viewModel.videoUrl
            self.videoView.player?.play()
        }
        
        addVideoView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openVideoPicker))
        videoView.addGestureRecognizer(tap)
        
        addLabel()
        
        addNextButton()
    }
}


private extension CreateVideoPostView {
    
    func addVideoView() {
        view.addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false

        videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        videoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        videoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        videoView.heightAnchor.constraint(equalTo: videoView.widthAnchor, multiplier: 16.0/9.0).isActive = true
    }
    
    func addLabel() {
        infoLabel.numberOfLines = 0
        infoLabel.text = "Tap here to select video".localizedLowercase
        infoLabel.textColor = .lightGray
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerXAnchor.constraint(equalTo: videoView.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: videoView.centerYAnchor).isActive = true
    }
    
    func addNextButton() {
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.widthAnchor.constraint(equalTo: nextButton.heightAnchor, multiplier: 2.0).isActive = true

        nextButton.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        nextButton.layoutIfNeeded()
    }
    
    @objc func openVideoPicker() {
        DispatchQueue.main.async {
            self.present(self.genericVideoPicker, animated: true, completion: nil)
        }
    }
    
    @objc func onNext() {
        coordinator?.navigateToNextScreen(viewModel.videoUrl!)
    }
}
