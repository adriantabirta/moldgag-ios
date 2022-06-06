//
//  GenericPostViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 28.05.2022.
//

import Foundation

class GenericPostViewModel {
    
    private let postId: String
    
    let index: Int
    
    init(postId: String, index: Int) {
        self.postId = postId
        self.index = index
    }
    
    func toggleFavorite() {
        // todo
    }
}
