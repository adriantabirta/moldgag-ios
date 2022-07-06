//
//  ImageRemoteDataSource.swift
//  moldgag
//
//  Created by Adrian Tabirta on 06.07.2022.
//

import UIKit
import Combine

protocol ImageRemoteDataSource {
    
    func getImageFor(_ url: URL) -> AnyPublisher<Optional<UIImage>, Never>

}
