//
//  ContentPickedDictionaryToImageUrlMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 15.07.2022.
//

import UIKit

protocol ContentPickedDictionaryToImageUrlMapper {
    
    func map(from model: Dictionary<UIImagePickerController.InfoKey, Any>) -> Optional<URL>
}
