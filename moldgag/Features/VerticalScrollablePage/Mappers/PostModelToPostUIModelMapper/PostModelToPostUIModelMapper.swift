//
//  PostModelToPostUIModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 28.05.2022.
//

protocol PostModelToPostUIModelMapper {
    
    func map(from model: Array<PostModel>) -> Array<VideoPostUIModel>
    
}
