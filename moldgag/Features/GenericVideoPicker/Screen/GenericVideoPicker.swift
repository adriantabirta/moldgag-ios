//
//  VideoPicker.swift
//  moldgag
//
//  Created by Adrian Tabirta on 14.07.2022.
//

import UIKit

class GenericVideoPicker: UIImagePickerController {
    
    // MARK: - Properties
    
    private var onPickVideoClosure: ([UIImagePickerController.InfoKey: Any]) -> Void = { _ in }
    
    // MARK: - UIImagePickerController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override var sourceType: UIImagePickerController.SourceType {
        get { .savedPhotosAlbum }
        set {}
    }
    
    override var mediaTypes: [String] {
        get { ["public.movie"] }
        set {}
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension GenericVideoPicker: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        onPickVideoClosure(info)
        picker.dismiss(animated: true, completion: {})
    }
    
    func infoToVideoUrl(_ info: [UIImagePickerController.InfoKey : Any]) -> Optional<URL> {
        return info[UIImagePickerController.InfoKey.mediaURL] as? URL
    }
}

// MARK: - Public

extension GenericVideoPicker {
    
    func onPick(_ completion: @escaping ([UIImagePickerController.InfoKey: Any]) -> Void) {
        self.onPickVideoClosure = completion
    }
}
