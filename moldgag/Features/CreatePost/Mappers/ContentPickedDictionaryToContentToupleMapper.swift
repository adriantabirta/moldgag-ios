//
//  ContentPickedDictionaryToUrlMapper.swift
//  moldgag
//
//  Created by Adrian Tabirta on 05.06.2022.
//

import UIKit
import Foundation

typealias ContentTouple = (contentUrl: URL, type: PostType)

protocol ContentPickedDictionaryToContentToupleMapper {
    
    func map(from model: Dictionary<UIImagePickerController.InfoKey, Any>) -> Optional<ContentTouple>
    
}
