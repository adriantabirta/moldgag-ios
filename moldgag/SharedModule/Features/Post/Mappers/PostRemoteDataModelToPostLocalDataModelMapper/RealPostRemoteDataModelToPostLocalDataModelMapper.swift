//
//  RealPostRemoteDataModelToPostLocalDataModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Foundation

struct RealPostRemoteDataModelToPostLocalDataModelMapper: PostRemoteDataModelToPostLocalDataModelMapper {
    
    func map(from model: Array<PostRemoteDataModel>) -> Array<PostLocalDataModel> {
        model.map({ PostLocalDataModel(id: $0.id, type: $0.type, url: $0.url) })
    }
}
