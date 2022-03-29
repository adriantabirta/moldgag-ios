//
//  Item.swift
//  moldgag
//
//  Created by Adrian Tabirta on 16.03.2022.
//

import Foundation

/// Item - content item
struct Item: Identifiable {
    
    enum ItemType {
        case video, image, adBanner
        // , audio, news
    }
    
    let id: String = UUID().uuidString
    
    let type: ItemType
    
    let url: String
}
