//
//  ImageItemView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import UIKit

/// ImageItemView -
class ImageItemView: GenericItemViewController {
         
    private let viewModel: ImageItemViewModel
    
    private var imageView: UIImageView
    
    init(_ viewModel: ImageItemViewModel, index: Int) {
        self.viewModel = viewModel
        self.imageView = CachebleImageView(url: viewModel.item.url) ?? UIImageView()
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = .black
        super.init(item: viewModel.item, index: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageItemView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = self.view.bounds
        view.addSubview(imageView)
    }
}
