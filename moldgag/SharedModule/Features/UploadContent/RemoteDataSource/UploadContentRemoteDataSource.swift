//
//  UploadContentRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 02.06.2022.
//

import Combine
import Foundation

protocol UploadContentRemoteDataSource {
    
    func upload(url: URL, postType: PostType) -> AnyPublisher<UploadResponseRemoteDataModel, ApplicationError>
    
}
