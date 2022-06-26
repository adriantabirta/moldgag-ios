//
//  PostRemoteDataModelToPostLocalDataModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 08.06.2022.
//

import Foundation

protocol PostRemoteDataModelToPostLocalDataModelMapper {
    
    func map(from model: Array<PostRemoteDataModel>) -> Array<PostLocalDataModel>
    
}
