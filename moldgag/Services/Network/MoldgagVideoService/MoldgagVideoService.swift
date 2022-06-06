//
//  MoldgagVideoService.swift
//  moldgag
//
//  Created by Adrian Tabirta on 22.03.2022.
//

import Foundation

protocol MoldgagVideoService {
    
    /// first
    func sayHello(for name: String) -> String
    
    /// Items for page
    func items(for page: Int) -> [VideoPostUIModel]
}
