//
//  FilenameToLocalPathMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Foundation

protocol FilenameToLocalPathMapper {
    
    func map(from filename: String) -> Optional<URL>
    
}
