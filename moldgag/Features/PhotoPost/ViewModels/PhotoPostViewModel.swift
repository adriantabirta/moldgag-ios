//
//  PhotoPostViewModel.swift
//  moldgag
//
//  Created by Adrian Tabirta on 28.05.2022.
//

import Combine
import Foundation

class PhotoPostViewModel: ObservableObject {
    
    let photoPostUIModel: PhotoPostUIModel
    
    @Published var url: URL
    
    init(photoPostUIModel: PhotoPostUIModel) {
        self.photoPostUIModel = photoPostUIModel
        self.url = photoPostUIModel.url
    }
}
