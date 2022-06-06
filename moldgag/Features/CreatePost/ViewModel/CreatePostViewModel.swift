//
//  CreatePostViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 05.06.2022.
//

import UIKit
import Combine
import Resolver
import Foundation

class CreatePostViewModel {
    
    // MARK: - Dependencies
    
    @Injected var createPostUseCase: CreatePostUseCase
    
    @Injected var mapper: ContentPickedDictionaryToUrlMapper
    
    // MARK: - Propreties
    
    private var bag = Set<AnyCancellable>()
    
    func create(from model: [UIImagePickerController.InfoKey : Any]) {
        guard let touple = mapper.map(from: model) else { return }
        createPostUseCase.execute(contentTouple: touple)
            .sink(receiveCompletion: { _ in }) { model in
                print("post created")
            }.store(in: &bag)
    }
    
}
