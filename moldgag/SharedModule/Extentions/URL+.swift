//
//  URL_.swift
//  moldgag
//
//  Created by Adrian Tabirta on 30.05.2022.
//

import Foundation

extension URL {
    
    /// filename from url. Example: "https://www.some.com/resource/file_name.mp4" will return "file_name.mp4"
    var fileName: String {
        return self.lastPathComponent
    }
}
