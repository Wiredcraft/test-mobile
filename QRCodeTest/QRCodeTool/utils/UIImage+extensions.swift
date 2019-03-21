//
//  UIImage+extensions.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/20.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func qrCodeImage(with string: String) -> UIImage? {
        let context = CIContext()
        let data = string.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter.init(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 7, y: 7)
            guard let output = filter.outputImage?.transformed(by: transform) else {
                return nil
            }
            guard let cgImage = context.createCGImage(output, from: output.extent) else {
                return nil
            }
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}
