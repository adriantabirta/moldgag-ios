//
//  AdvertisingPostView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import UIKit
//import MediaPlayer

class AdvertisingPostView: GenericPostView {
        
    var audioLevel: Float = 0
    
    private let viewModel: AdvertisingViewModel
    
    init(_ viewModel: AdvertisingViewModel, index: Int) {
        self.viewModel = viewModel
        super.init(genericPostViewModel: GenericPostViewModel(postId: viewModel.item.id, index: index))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdvertisingPostView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        let label = UILabel(frame: self.view.frame)
        label.text = "Aici poate fi ceva ...\n pentru mai multe detalii APASA"
        label.font = .systemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        view.addSubview(label)
        
        
        let viewRed = UIView()
        viewRed.backgroundColor = UIColor.init(red: 128/255, green: 0/255, blue: 0/255, alpha: 0.5)
        viewRed.translatesAutoresizingMaskIntoConstraints = false
    
        view .addSubview(viewRed)
        
        viewRed.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewRed.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewRed.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewRed.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }
}
