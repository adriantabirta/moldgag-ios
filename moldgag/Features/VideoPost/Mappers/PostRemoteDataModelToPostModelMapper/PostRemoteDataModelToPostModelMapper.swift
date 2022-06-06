//
//  PostRemoteDataModelToPostMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

protocol PostRemoteDataModelToPostModelMapper {
    
    func map(from model: PostRemoteDataModel) -> PostModel?
    
}
