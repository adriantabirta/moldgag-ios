//
//  LoadingScreenViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 11.06.2022.
//

import Resolver
import Combine

class LoadingScreenViewModel: ObservableObject {
    
    @Injected var refreshPostsUseCase: RefreshPostsUseCase
    
    @Published var isLoading: Bool = true
    
}

extension LoadingScreenViewModel {
    
    func preloadApplicationConent() -> AnyPublisher<Void, Never> {
        refreshPostsUseCase.execute()
            .handleEvents(receiveOutput: {
                self.isLoading = false
                
            }).eraseToAnyPublisher()
    }
}
