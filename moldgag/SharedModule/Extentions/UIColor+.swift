//
//  UIColor_.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.05.2022.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}
