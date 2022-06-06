//
//  PostDatabaseModelToPostMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

protocol PostLocalDataModelToPostMapper {
    
    func map(from model: PostLocalDataModel) -> PostModel?
    
}
