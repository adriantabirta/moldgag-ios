//
//  GetPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Combine

protocol GetPostsStreamUseCase {
    
    func execute() -> AnyPublisher<Array<PostModel>, Never>
    
}
