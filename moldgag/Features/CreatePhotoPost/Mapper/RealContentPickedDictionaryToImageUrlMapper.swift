//
//  RealContentPickedDictionaryToImageUrlMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 15.07.2022.
//

import UIKit

struct RealContentPickedDictionaryToImageUrlMapper: ContentPickedDictionaryToImageUrlMapper {
    
    func map(from model: Dictionary<UIImagePickerController.InfoKey, Any>) -> Optional<URL> {
        guard let mediaType = model[UIImagePickerController.InfoKey.mediaType] as? String, mediaType == "public.image",
              let photoUrl = model[UIImagePickerController.InfoKey.imageURL] as? URL,
              let finalUrl = URL(string: String(photoUrl.absoluteString.dropFirst(7))) else {
            return nil
        }
        return finalUrl
    }
}
