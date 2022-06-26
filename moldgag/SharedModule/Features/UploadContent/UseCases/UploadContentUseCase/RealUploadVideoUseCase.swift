//
//  RealUploadVideoUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 02.06.2022.
//

import Combine
import Resolver
import Foundation

class RealUploadContentUseCase {
    
    // MARK: - Dependencies
    
    @Injected var uploadContentRemoteDataSource: UploadContentRemoteDataSource
    
    @Injected var postRemoteDataSource: PostRemoteDataSource
    
}

// MARK: - UploadVideoUseCase

extension RealUploadContentUseCase: UploadContentUseCase {
   
    func execute(url: URL, postType: PostType) -> AnyPublisher<UploadResponseRemoteDataModel, ApplicationError> {
        
        // todo: check file size

        // see: https://api.imgur.com
        // approximately 1,250 uploads per day or approximately 12,500 requests per day.
        
        
        // https://api.imgur.com/3/credits
        /*
         "data": {
                "UserLimit": 2000,
                "UserRemaining": 2000,
                "UserReset": 1654440380,
                "ClientLimit": 12500,
                "ClientRemaining": 12500
            },
         */
        
        return uploadContentRemoteDataSource.upload(url: url, postType: postType).eraseToAnyPublisher()
        
        
    }
}
