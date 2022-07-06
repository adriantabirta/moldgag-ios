//
//  ImageLocalDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 06.07.2022.
//

import UIKit
import Combine

protocol ImageLocalDataSource {
    
    func getImageFor(_ url: URL) -> Optional<UIImage>
    
    func save(_ image: UIImage, for url: URL)
    
    func cleanCache()
    
}
