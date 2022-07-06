//
//  ImageRepository.swift
//  moldgag
//
//  Created by Adrian Tabirta on 06.07.2022.
//

import Combine
import UIKit

protocol ImageRepository {
    
    func getImageFor(_ url: URL) -> AnyPublisher<Optional<UIImage>, Never>
    
    func cleanCache() -> AnyPublisher<Void, Never>

}
