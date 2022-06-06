//
//  PhotoPostUIModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 28.05.2022.
//

import Foundation

struct PhotoPostUIModel {
    
    let id: String = UUID().uuidString
    
    let type: PostType
    
    let url: URL
}
