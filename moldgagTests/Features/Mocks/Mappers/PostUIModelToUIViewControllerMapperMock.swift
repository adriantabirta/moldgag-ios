//
//  PostUIModelToUIViewControllerMapperMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import UIKit
import Combine
@testable import moldgag

class PostUIModelToUIViewControllerMapperMock: PostUIModelToUIViewControllerMapper {

    var invokedMap = false
    var invokedMapCount = 0
    var invokedMapParameters: (model: VideoPostUIModel, index: Int)?
    var invokedMapParametersList = [(model: VideoPostUIModel, index: Int)]()
    var stubbedMapResult: UIViewController!

    func map(from model: VideoPostUIModel, and index: Int) -> UIViewController? {
        invokedMap = true
        invokedMapCount += 1
        invokedMapParameters = (model, index)
        invokedMapParametersList.append((model, index))
        return stubbedMapResult
    }
}
