//
//  CreatePostPartTwoViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 07.06.2022.
//

import UIKit
import Combine
import Resolver

class CreatePostPartTwoViewModel {
    
    // MARK: - Dependencies
    
    @Injected var createPostUseCase: CreatePostUseCase
    
    @Injected var mapper: ContentPickedDictionaryToContentToupleMapper
    
    private let model: CreatePostPartTwoUIModel
    
//    @Published var counter: String = "0/100"
    
    private var bag = Set<AnyCancellable>()
    
    init(_ model: CreatePostPartTwoUIModel) {
        self.model = model
    }

}

// MARK: - Public

extension CreatePostPartTwoViewModel {
    
    func createPost(with title: Optional<String>) {
        guard let title = title else { return } // show error
//        createPostUseCase.execute(title: title, contentUrl: model.url, postType: model.postType)
//            .sink(receiveCompletion: { _ in }) { model in
//                print("post created")
//            }.store(in: &bag)
    }
    
}

