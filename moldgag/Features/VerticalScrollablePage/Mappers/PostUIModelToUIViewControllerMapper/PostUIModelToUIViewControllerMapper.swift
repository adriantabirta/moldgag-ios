//
//  PostUIModelToUIViewControllerMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import UIKit

protocol PostUIModelToUIViewControllerMapper {
    
    func map(from model: VideoPostUIModel, and index: Int) -> UIViewController?
    
}
