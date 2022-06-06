//
//  RealPostModelToPostUIModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 28.05.2022.
//

import Foundation

struct RealPostModelToPostUIModelMapper: PostModelToPostUIModelMapper {
    
    func map(from model: PostModel) -> VideoPostUIModel? {
        guard let url = URL(string: model.url) else { return nil }
        return VideoPostUIModel(type: model.type, url: url)
    }
    
}
