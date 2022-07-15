//
//  CreateVideoPostViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 14.07.2022.
//

import UIKit
import Combine
import Resolver
import Foundation

class CreateVideoPostViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    @Injected var mapper: ContentPickedDictionaryToVideoUrlMapper
    
    // MARK: - Propreties
    
    @Published var videoUrl: URL?
    
}

// MARK: - Public

extension CreateVideoPostViewModel {
    
    func configure(with model: [UIImagePickerController.InfoKey : Any]) {
        guard let url = mapper.map(from: model) else { return }
        self.videoUrl = url
    }
}
