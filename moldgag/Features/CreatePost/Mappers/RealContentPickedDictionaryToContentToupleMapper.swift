//
//  RealContentPickedDictionaryToContentToupleMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 05.06.2022.
//

import UIKit
import Foundation

struct RealContentPickedDictionaryToContentToupleMapper: ContentPickedDictionaryToContentToupleMapper {
    
    func map(from model: Dictionary<UIImagePickerController.InfoKey, Any>) -> Optional<ContentTouple> {
        
        if let mediaType = model[UIImagePickerController.InfoKey.mediaType] as? String,
           mediaType == "public.image",
           let photoUrl = model[UIImagePickerController.InfoKey.imageURL] as? URL,
           let finalUrl = URL(string: String(photoUrl.absoluteString.dropFirst(7))) {
         
            return ContentTouple(finalUrl, .image)
            
        } else if let videoURL = model[UIImagePickerController.InfoKey.mediaURL] as? URL,
                  let finalUrl = URL(string: String(videoURL.absoluteString.dropFirst(7))) {
        
            return ContentTouple(finalUrl, .video)
        }
        
        return nil
    }
}
