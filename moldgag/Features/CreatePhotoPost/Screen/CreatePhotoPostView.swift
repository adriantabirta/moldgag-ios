//
//  CreatePhotoPostView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 15.07.2022.
//

import UIKit
import Resolver

class CreatePhotoPostView: UIViewController {
    
    // MARK: - Dependencies
    
    @Injected var viewModel: CreatePhotoPostViewModel
    
    // MARK: - Properties

    private lazy var genericImagePicker = GenericImagePicker()
    
    weak var coordinator: CreatePhotoPostCoordinator?
}

extension CreatePhotoPostView {
    
    @objc func openImagePicker() {
        DispatchQueue.main.async {
            self.present(self.genericImagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func onNext() {
        guard let url = viewModel.imageUrl else { return }
        coordinator?.navigateToNextScreen(url)
    }
}
