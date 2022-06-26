//
//  UploadResponseRemoteDataModelStub.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

@testable import moldgag

extension UploadResponseRemoteDataModel: Stubbable {
    
    static func stub() -> UploadResponseRemoteDataModel {
        let data = UploadData(id: "1", link: "https://content.com/img.jpg")
        return UploadResponseRemoteDataModel(status: 200, success: true, data: data)
    }
}
