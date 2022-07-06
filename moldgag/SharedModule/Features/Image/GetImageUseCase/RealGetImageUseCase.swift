//
//  RealGetImageUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 06.07.2022.
//

import UIKit
import Combine
import Resolver

struct RealGetImageUseCase {
    
    @Injected private var imageRepository: ImageRepository
    
}

// MARK: - GetImageUseCase

extension RealGetImageUseCase: GetImageUseCase {
    
    func execute(for url: URL) -> AnyPublisher<Optional<UIImage>, Never> {
        imageRepository.getImageFor(url)
    }
}
