//
//  UploadContentRemoteDataSourceMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import Combine
import Foundation
@testable import moldgag

class UploadContentRemoteDataSourceMock: UploadContentRemoteDataSource {

    var invokedUpload = false
    var invokedUploadCount = 0
    var invokedUploadParameters: (url: URL, postType: PostType)?
    var invokedUploadParametersList = [(url: URL, postType: PostType)]()
    var stubbedUploadResult: AnyPublisher<UploadResponseRemoteDataModel, ApplicationError>!

    func upload(url: URL, postType: PostType) -> AnyPublisher<UploadResponseRemoteDataModel, ApplicationError> {
        invokedUpload = true
        invokedUploadCount += 1
        invokedUploadParameters = (url, postType)
        invokedUploadParametersList.append((url, postType))
        return stubbedUploadResult
    }
}
