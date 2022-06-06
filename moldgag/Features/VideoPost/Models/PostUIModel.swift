//
//  ItemUIModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 16.03.2022.
//

import Foundation

struct VideoPostUIModel: Identifiable {
    
    let id: String = UUID().uuidString
    
    let type: PostType
    
    let url: URL
    
}
