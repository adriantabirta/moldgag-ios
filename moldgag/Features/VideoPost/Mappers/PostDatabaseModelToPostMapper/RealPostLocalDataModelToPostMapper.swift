//
//  RealPostDatabaseModelToPostMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

struct RealPostLocalDataModelToPostMapper: PostLocalDataModelToPostMapper {
    
    func map(from model: PostLocalDataModel) -> PostModel? {
        guard let type = PostType(rawValue: model.type) else { return nil }
        return PostModel(id: model.id, type: type, url: model.url)
    }
    
}
