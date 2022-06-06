//
//  RealPostRemoteDataModelToPostModelMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

struct RealPostRemoteDataModelToPostModelMapper: PostRemoteDataModelToPostModelMapper {
    
    func map(from model: PostRemoteDataModel) -> PostModel? {
        guard let type = PostType(rawValue: model.type) else { return nil }
        return PostModel(id: model.id, type: type, url: model.url)
    }
}
