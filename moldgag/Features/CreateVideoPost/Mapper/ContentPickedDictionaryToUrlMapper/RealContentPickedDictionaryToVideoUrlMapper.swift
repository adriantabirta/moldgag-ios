//
//  RealContentPickedDictionaryToVideoUrlMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 14.07.2022.
//

import UIKit

struct RealContentPickedDictionaryToVideoUrlMapper: ContentPickedDictionaryToVideoUrlMapper {
    
    func map(from model: Dictionary<UIImagePickerController.InfoKey, Any>) -> Optional<URL> {
        guard let videoURL = model[UIImagePickerController.InfoKey.mediaURL] as? URL,
              let finalUrl = URL(string: String(videoURL.absoluteString.dropFirst(7))) else { return nil }
        return finalUrl
    }
}
