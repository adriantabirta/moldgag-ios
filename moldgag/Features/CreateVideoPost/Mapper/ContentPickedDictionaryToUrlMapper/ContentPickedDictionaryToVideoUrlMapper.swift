//
//  ContentPickedDictionaryToVideoUrlMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 14.07.2022.
//

import UIKit

protocol ContentPickedDictionaryToVideoUrlMapper {
    
    func map(from model: Dictionary<UIImagePickerController.InfoKey, Any>) -> Optional<URL>
}
