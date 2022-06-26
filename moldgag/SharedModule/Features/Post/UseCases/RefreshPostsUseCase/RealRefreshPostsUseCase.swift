//
//  RealRefreshPostsUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Combine
import Resolver

struct RealRefreshPostsUseCase {
    
    // MARK: - Dependencies
    
    @Injected var deleteAllPostsUseCase: DeleteAllPostsUseCase
    
    @Injected var loadPostsForPageUseCase: LoadPostsForPageUseCase
    
}

// MARK: - RefreshPostsUseCase

extension RealRefreshPostsUseCase: RefreshPostsUseCase {
    
    func execute() -> AnyPublisher<Void, Never> {
        Publishers.Zip(deleteAllPostsUseCase.execute(), loadPostsForPageUseCase.execute(for: 0))
            .map{ _, _ in Void() }
            .eraseToAnyPublisher()
    }
}
