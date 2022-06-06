//
//  RealCreatePostUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 05.06.2022.
//

import Combine
import Resolver
import Foundation

// Upload to imgur.com -> create a post with url to backend -> return

class RealCreatePostUseCase {
    
    // MARK: - Dependencies
    
    @Injected var uploadVideoUseCase: UploadContentUseCase
    
    @Injected var postRemoteDataSource: PostRemoteDataSource
    
    @Injected var mapper: PostRemoteDataModelToPostModelMapper

}

// MARK: - CreatePostUseCase

extension RealCreatePostUseCase: CreatePostUseCase  {
    
    func execute(contentTouple: ContentTouple) -> AnyPublisher<PostModel, ApplicationError> {
        uploadVideoUseCase.execute(url: contentTouple.conentUrl, postType: contentTouple.type)
            .flatMap({ model in
                self.postRemoteDataSource.create(from: model.data.link, title: "", and: .video)
                    .compactMap({ self.mapper.map(from: $0) })
                    .mapError({ ApplicationError($0) })
            })
            .eraseToAnyPublisher()
    }
    
}
