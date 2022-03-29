//
//  MoldgagError.swift
//  moldgag
//
//  Created by Adrian Tabirta on 16.03.2022.
//

import Foundation

/// MoldgagError - global error
enum MoldgagError: Error {
    
    case video(String)
    
    case unknown
    
    init(_ description: String) {
        self = .video(description)
    }
}
