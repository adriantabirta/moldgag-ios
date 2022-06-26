//
//  FilenameToLocalPathMapperMock.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Foundation

class FilenameToLocalPathMapperMock: FilenameToLocalPathMapper {

    var invokedMap = false
    var invokedMapCount = 0
    var invokedMapParameters: (filename: String, Void)?
    var invokedMapParametersList = [(filename: String, Void)]()
    var stubbedMapResult: Optional<URL>!

    func map(from filename: String) -> Optional<URL> {
        invokedMap = true
        invokedMapCount += 1
        invokedMapParameters = (filename, ())
        invokedMapParametersList.append((filename, ()))
        return stubbedMapResult
    }
}
