//
//  RealPostUIModelToUIViewControllerMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import UIKit

struct RealPostUIModelToUIViewControllerMapper: PostUIModelToUIViewControllerMapper {
    
    func map(from model: VideoPostUIModel, and index: Int) -> UIViewController? {
        
        if model.type == .video {
            return VideoPostView(.init(postUIModel: model), index: index)
        }
        
        if model.type == .image {
            return PhotoPostView(viewModel: .init(photoPostUIModel: PhotoPostUIModel(type: .image, url: model.url)), index: index)
        }
        
        if model.type == .adBanner {
            return AdvertisingPostView(AdvertisingViewModel(item: model), index: index)
        }
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.random()

        return vc
    }
}
