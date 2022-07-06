//
//  GetImageUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 06.07.2022.
//

import UIKit
import Combine

protocol GetImageUseCase {
    
    func execute(for url: URL) -> AnyPublisher<Optional<UIImage>, Never>
    
}
