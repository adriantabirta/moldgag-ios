//
//  CreatePostPartOneViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 05.06.2022.
//

import UIKit
import Combine
import Resolver
import Foundation

class CreatePostPartOneViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    @Injected var mapper: ContentPickedDictionaryToContentToupleMapper
    
    // MARK: - Propreties
    
    @Published var image: UIImage?
    
    @Published var videoUrl: URL?
    
    var stepTwoModel: CreatePostPartTwoUIModel!
    
    private var bag = Set<AnyCancellable>()

}

// MARK: - Public

extension CreatePostPartOneViewModel {
    
    func configure(with model: [UIImagePickerController.InfoKey : Any]) {
        guard let touple = mapper.map(from: model) else { return }
        self.stepTwoModel = CreatePostPartTwoUIModel(url: touple.contentUrl, postType: touple.type)
        if touple.type == .video {
            self.videoUrl = touple.contentUrl
        }
        
        if touple.type == .image {
            self.image = UIImage(contentsOfFile: touple.contentUrl.absoluteString)
        }
    }
}
