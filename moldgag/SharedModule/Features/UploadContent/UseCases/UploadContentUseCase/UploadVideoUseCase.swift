//
//  UploadContentUseCase.swift
//  moldgag
//
//  Created by Adrian Tabirta on 02.06.2022.
//

import Combine
import Foundation

protocol UploadContentUseCase {
    
    func execute(url: URL, postType: PostType) -> AnyPublisher<UploadResponseRemoteDataModel, ApplicationError>
    
}
