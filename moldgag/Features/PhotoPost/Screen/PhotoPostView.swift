//
//  PhotoPostView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 28.05.2022.
//

import UIKit
import Combine
import Resolver

class PhotoPostView: GenericPostView {
    
    // MARK: - Dependencies
    
    @Injected var imageCacheService: ImageCacheService
    
    // MARK: - Propreties
    
    private var viewModel: PhotoPostViewModel
    
    private var imageView: UIImageView
    
    private var bag = Set<AnyCancellable>()
    
    init(viewModel: PhotoPostViewModel, index: Int) {
        self.viewModel = viewModel
        self.imageView = .init()
        super.init(genericPostViewModel: .init(postId: viewModel.photoPostUIModel.id, index: index))
        
        imageCacheService.cacheImage(for: viewModel.url).assign(to: \.image, on: imageView).store(in: &bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = self.view.bounds
        view.addSubview(imageView)
        
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = .black
    }
}
