//
//  PostRemoteDataModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import Foundation

struct PostRemoteDataModel: Decodable {
    
    let id: String = UUID().uuidString
    
    let type: String
    
    let url: String
    
    let score: Int = (1...1000).randomElement() ?? 1
}

