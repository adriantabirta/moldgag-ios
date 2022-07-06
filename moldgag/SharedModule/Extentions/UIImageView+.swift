//
//  UIImageView+.swift
//  moldgag
//
//  Created by Adrian Tabirta on 29.05.2022.
//

import UIKit
import Foundation

//extension UIImageView {
//    
//    /// Loads image from web asynchronosly and caches it, in case you have to load url
//    /// again, it will be loaded from cache if available
//    func load(url: URL, placeholder: UIImage? = nil, cache: URLCache? = nil) {
//        let cache = cache ?? URLCache.shared
//        let request = URLRequest(url: url)
//        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        } else {
//            self.image = placeholder
//            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
//                    let cachedData = CachedURLResponse(response: response, data: data)
//                    cache.storeCachedResponse(cachedData, for: request)
//                    
//                    DispatchQueue.main.async {
//                        self.image = image
//                    }
//                }
//            }).resume()
//        }
//    }
//}

extension UIDevice {
    /// Returns `true` if the device has a notch
    var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}


extension UIImage {
    
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
