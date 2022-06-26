//
//  PostModelStub.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

@testable import moldgag

extension PostModel: Stubbable {
    
    static func stub() -> PostModel {
        PostModel(id: "id", type: .image, url: "https://content.com/image.jpg")
    }
}
