//
//  CreatePostView.swift
//  moldgag
//
//  Created by Adrian Tabirta on 02.06.2022.
//

import UIKit
import Combine
import Resolver
import UniformTypeIdentifiers

class CreatePostView: UIViewController {
    
    @Injected var viewModel: CreatePostViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .random()
        
        let button = UIButton(type: .contactAdd)
        view.addSubview(button)
        button.center = view.center
        button.addTarget(self, action: #selector(selectFile), for: .touchUpInside)
        
        //        let screenSize: CGRect = UIScreen.main.bounds
        //        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        //        let navItem = UINavigationItem(title: "Create new post")
        //        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(dissmissView))
        //        navItem.rightBarButtonItem = doneItem
        //        navBar.setItems([navItem], animated: false)
        //        self.view.addSubview(navBar)
        //
        //        self.title = "Create new post"
        //        self.view.backgroundColor = .random()
    }
    
    @objc func selectFile() {
        
        let pickerController = UIImagePickerController()
        
        /*
         * Part 1: Select the origin of media source
         Either one of the belows:
         1. .photoLibrary     -> Go to album selection page
         2. .savedPhotosAlbum -> Go to Moments directly
         */
        pickerController.sourceType = .savedPhotosAlbum
        
        // Must import `UniformTypeIdentifiers`
        // Part 2: Allow user to select both image and video as source
        //        pickerController.mediaTypes = [UTType.image.raw, UTType.video]
        pickerController.mediaTypes = ["public.image", "public.movie"]
        
        // Part 3: User can optionally crop only a certain part of the image or video with iOS default tools
        pickerController.allowsEditing = true
        
        // Part 4: For callback of user selection / cancellation
        pickerController.delegate = self
        
        // Part 5: Show UIImagePickerViewController to user
        present(pickerController, animated: true, completion: nil)
    }
    
}

extension CreatePostView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: { self.viewModel.create(from: info) })
    }
}
