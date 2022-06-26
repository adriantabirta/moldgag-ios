//
//  CreatePostPartOneView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 02.06.2022.
//

import UIKit
import Combine
import Resolver
import UniformTypeIdentifiers

class CreatePostPartOneView: UIViewController {
    
    // MARK: - Dependencies
    
    @Injected var viewModel: CreatePostPartOneViewModel
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var videoContainerView: UIView?
    
    @IBOutlet weak var imageContainerView: UIImageView?
    
    // MARK: - Propreties
    
    private lazy var pickerController = UIImagePickerController()
    
    private lazy var videoView = VideoView()
    
    private var bag = Set<AnyCancellable>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = pickerController.view
        
        viewModel.$videoUrl.compactMap({ $0 })
            .receive(on: RunLoop.main)
            .sink(receiveValue: { url in
                self.videoView.frame = self.videoContainerView?.frame ?? .zero
                self.videoContainerView?.addSubview(self.videoView)
                self.videoView.player?.play()
            })
            .store(in: &bag)
        
        viewModel.$image
            .compactMap({ $0 })
            .receive(on: RunLoop.main)
            .sink(receiveValue: {
                self.imageContainerView?.image = $0
            }).store(in: &bag)
    }
    
    @IBAction func selectFile() {
        
        /*
         * Part 1: Select the origin of media source
         Either one of the belows:
         1. .photoLibrary     -> Go to album selection page
         2. .savedPhotosAlbum -> Go to Moments directly
         */
        pickerController.sourceType = .savedPhotosAlbum
        //        pickerController.cameraCaptureMode = .video
        //        pickerController.cameraCaptureMode
        
        // Must import `UniformTypeIdentifiers`
        // Part 2: Allow user to select both image and video as source
        //        pickerController.mediaTypes = [UTType.image.raw, UTType.video]
        pickerController.mediaTypes = ["public.image", "public.movie"]
        
        // Part 3: User can optionally crop only a certain part of the image or video with iOS default tools
        pickerController.allowsEditing = true
        
        // Part 4: For callback of user selection / cancellation
        pickerController.delegate = self
        
        // Part 5: Show UIImagePickerViewController to user
        DispatchQueue.main.async {
            self.present(self.pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onNext() {
        let vc = CreatePostPartTwoView(.init(viewModel.stepTwoModel))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CreatePostPartOneView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageContainerView?.image = nil
        videoContainerView?.subviews.forEach({ $0.removeFromSuperview() })
        
        if let videoUrl = infoToVideoUrl(info) {
            self.videoView.frame = self.videoContainerView?.frame ?? .zero
            self.videoContainerView?.addSubview(self.videoView)
            self.videoView.url = videoUrl
            self.videoView.player?.play()
        }
        
        viewModel.configure(with: info)
        picker.dismiss(animated: true, completion: {})
    }
    
    func infoToVideoUrl(_ info: [UIImagePickerController.InfoKey : Any]) -> Optional<URL> {
        return info[UIImagePickerController.InfoKey.mediaURL] as? URL
    }
}
