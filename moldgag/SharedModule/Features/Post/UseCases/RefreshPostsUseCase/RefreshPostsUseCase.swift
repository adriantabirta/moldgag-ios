//
//  RefreshPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Combine

protocol RefreshPostsUseCase {
    
    func execute() -> AnyPublisher<Void, Never>
    
}
