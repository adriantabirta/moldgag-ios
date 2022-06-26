//
//  DeleteAllPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Combine

protocol DeleteAllPostsUseCase {
    
    func execute() -> AnyPublisher<Void, Never>
    
}
