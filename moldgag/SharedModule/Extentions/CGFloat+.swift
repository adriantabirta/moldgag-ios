//
//  CGFloat+.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.05.2022.
//

import UIKit

extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
