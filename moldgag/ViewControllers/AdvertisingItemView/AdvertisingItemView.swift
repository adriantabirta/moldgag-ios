//
//  AdvertisingItemView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 19.02.2022.
//

import UIKit
import MediaPlayer

/// AdvertisingItemView -
class AdvertisingItemView: GenericItemViewController {
        
    var audioLevel: Float = 0
    
    private let viewModel: AdvertisingItemViewModel
    
    init(_ viewModel: AdvertisingItemViewModel, index: Int) {
        self.viewModel = viewModel
        super.init(item: viewModel.item, index: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdvertisingItemView {
    
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

        
        
        // remove volume slider
        
        let volumeView = MPVolumeView(frame: CGRect.zero)
        for subview in volumeView.subviews {
            if let button = subview as? UIButton {
                button.setImage(nil, for: .normal)
                button.isEnabled = false
                button.sizeToFit()
            }
        }
        
        UIApplication.shared.windows.first?.addSubview(volumeView)
        UIApplication.shared.windows.first?.sendSubviewToBack(volumeView)
       
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setActive(true, options: [])
//            audioSession.addObserver(self, forKeyPath: "outputVolume",
//                                     options: NSKeyValueObservingOptions.new, context: nil)
//             audioLevel = audioSession.outputVolume
//        } catch {
//            print("Error")
//        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            let audioSession = AVAudioSession.sharedInstance()
            if audioSession.outputVolume > audioLevel {
//                print("Hello")
            }
            if audioSession.outputVolume < audioLevel {
//                print("GoodBye")
            }
            audioLevel = audioSession.outputVolume
            print(audioSession.outputVolume)
        }
    }
    
    
}
