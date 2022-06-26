//
//  RealFilenameToLocalPathMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Foundation

class RealFilenameToLocalPathMapper: FilenameToLocalPathMapper {
    
    func map(from filename: String) -> Optional<URL> {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { return nil }
        return path.appendingPathComponent(filename)
    }
    
}
